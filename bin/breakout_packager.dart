import 'dart:io';

import 'package:toml/toml.dart';
import 'output_template.dart' as template;

void main(List<String> arguments) async {
  // What it do:
  // 1. Take in a file as an argument (levels.toml)
  // 2. Read from the files, settings defined in that config file
  // 3. Package them together as "levels.h"
  // Tada!
  String inputFilename;
  if (arguments.isEmpty) {
    print('Missing an input file - assuming default "levels.toml".');
    inputFilename = 'levels.toml';
  } else {
    inputFilename = arguments[0];
  }

  // Attempt to load the first argument as a file
  Map<String, dynamic> configFile;
  try {
    configFile = (await TomlDocument.load(inputFilename)).toMap();
    print('Succesfully read $inputFilename.');
  } catch (e) {
    print('ERROR: Unable to read file $inputFilename');
    print(e);
    return;
  }

  // Parse the data in the config file
  List<dynamic> filesToPrepare;
  String destination;
  try {
    filesToPrepare = configFile['input_files'];
    destination = configFile['output_file'];
  } catch (e) {
    print('ERROR: Config file missing properties');
    print(e);
    return;
  }

  print('Found ${filesToPrepare.length} files to read');
  print('Output File: $destination');
  print('---');

  // Open destination file
  var destinationFile = File(destination);
  var sink = destinationFile.openWrite();

  // Write the header to the file
  sink.write(template.FILE_HEADER);
  sink.write('\n');

  // Steps:
  // 1. Load each file sequentially
  // 2. Write its per-line data to the file (with prefixes/suffixes)
  // 3. When all files have been processed, write levels object
  var levelsInFile = <int>[];
  var blocksInFile = <int>[];
  for (var i = 0; i < filesToPrepare.length; i++) {
    var filename = filesToPrepare[i];

    // Attempt to open the file
    try {
      // Open the file
      var levelFile = File(filename);
      // Get the contents
      var levelContents = await levelFile.readAsString();
      // Split each line into a separate string
      var dataBlocks = levelContents.split('\n');
      if (dataBlocks.length <= 1) {
        print(
            'WARNING: File $filename is using the deprecated colorless format. A default palette will be generated');
      }

      var numBlocks = dataBlocks[0].split('}, ').length;

      if (numBlocks > 30) {
        print('Level $filename has $numBlocks/30 blocks.');
        print(
            'ERROR: No more than 30 blocks can be allowed in a single level. This file will not be included in the package.');
        continue;
      }

      // Write the blocks data into the file
      sink.write(template.BLOCKS_PREFIX);
      sink.write('${i}_BLOCKS[30] = ${dataBlocks[0]};\n');

      // Write the color palette data into the file
      sink.write(template.COLORS_PREFIX);
      sink.write('${i}_COLORS[30] = ');
      if (dataBlocks.length <= 1) {
        // The default color palette is just a single blue color
        sink.write('{0x000000FF};\n');
      } else {
        sink.write('${dataBlocks[1]};\n');
      }

      // Write the color bindings to the file
      sink.write(template.BINDINGS_PREFIX);
      sink.write('${i}_BINDINGS[30] = ');
      if (dataBlocks.length <= 1) {
        // The default bindings is just binding all blocks to the primary color
        var bindingValues = List<String>.filled(numBlocks, '0');
        sink.write('{${bindingValues.join(', ')}};\n');
      } else {
        sink.write('${dataBlocks[2]};\n');
      }
      sink.write('\n');

      print('File $filename written into package.');

      levelsInFile.add(i);
      blocksInFile.add(numBlocks);
    } catch (e) {
      print(
          'ERROR: Unable to properly parse file $filename. This file will not be included in the package.');
      print(e);
      continue;
    }
  }

  // We've now parsed all files. Time to wrap up the package.
  // This just involves creating the LEVELS struct
  sink.write('\n');
  sink.write(template.LEVELS_PREFIX);
  sink.write(levelsInFile.length);
  sink.write('] = {\n');
  var assembledLevelBlocks = <String>[];
  for (var i = 0; i < levelsInFile.length; i++) {
    var element = levelsInFile[i];
    assembledLevelBlocks.add(
        '\t{LEVEL_${element}_BLOCKS, LEVEL_${element}_COLORS, LEVEL_${element}_BINDINGS, ${blocksInFile[i]}}');
  }
  sink.write(assembledLevelBlocks.join(',\n'));
  sink.write('};\n\n');

  sink.write('#define NUM_LEVELS ${levelsInFile.length}\n');

  sink.write(template.FILE_FOOTER);

  // The file is done!
  await sink.close();
  print('---');
  print(
      'Sucesfully packaged ${levelsInFile.length} files into $destinationFile');
  return;
}
