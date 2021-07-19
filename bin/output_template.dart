const FILE_HEADER = '''#ifndef LEVELS_H_
#define LEVELS_H_

#include "GrLib/grlib/grlib.h"

typedef struct level {
    const Graphics_Rectangle* blocks;
    const int32_t* colors;
    const char* bindings;
    int numBlocks;
} Level;
''';

const FILE_FOOTER = '''#endif /* LEVELS_H_ */''';

const BLOCKS_PREFIX = '''const Graphics_Rectangle LEVEL_''';
const COLORS_PREFIX = '''const int32_t LEVEL_''';
const BINDINGS_PREFIX = '''const char LEVEL_''';
const LEVELS_PREFIX = '''const Level LEVELS[''';
const GENERAL_SUFFIX = '''};
''';
/*
const Graphics_Rectangle LEVEL_1_BLOCKS[30] = {
                                {1, 1, 20, 8}, {22, 1, 42, 8}, {44, 1, 64, 8}, {66, 1, 86, 8}, {88, 1, 108, 8}, {110, 1, 127, 8},
                                {1, 10, 20, 18}, {22, 10, 42, 18}, {44, 10, 64, 18}, {66, 10, 86, 18}, {88, 10, 108, 18}, {110, 10, 127, 18},
                                {1, 20, 20, 28}, {22, 20, 42, 28}, {44, 20, 64, 28}, {66, 20, 86, 28}, {88, 20, 108, 28}, {110, 20, 127, 28},
                                {1, 30, 20, 38}, {22, 30, 42, 38}, {44, 30, 64, 38}, {66, 30, 86, 38}, {88, 30, 108, 38}, {110, 30, 127, 38},
                                {1, 40, 20, 48}, {22, 40, 42, 48}, {44, 40, 64, 48}, {66, 40, 86, 48}, {88, 40, 108, 48}, {110, 40, 127, 48}
};

const int32_t LEVEL_1_COLORS[30] = {0x00FF0000, 0x0000FF00, 0x000000FF, 0x00FF00FF};
const char LEVEL_1_BINDING[30] = {1, 2, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3};

const Graphics_Rectangle LEVEL_2_BLOCKS[30] = {{0, 8, 16, 16}, {8, 16, 24, 24}, {16, 24, 32, 32}, {24, 32, 40, 40}, {32, 40, 48, 48}, {40, 48, 56, 56}, {48, 56, 64, 64}, {56, 48, 72, 56}, {64, 40, 80, 48}, {72, 32, 88, 40}, {80, 24, 96, 32}, {88, 16, 104, 24}, {96, 8, 112, 16}, {88, 0, 104, 8}, {72, 0, 88, 8}, {56, 0, 72, 8}, {40, 0, 56, 8}, {24, 0, 40, 8}, {8, 0, 24, 8}, {48, 40, 64, 48}, {64, 24, 80, 32}, {80, 8, 96, 16}, {32, 24, 48, 32}, {16, 8, 32, 16}, {48, 24, 64, 32}, {56, 16, 72, 24}, {64, 8, 80, 16}, {40, 16, 56, 24}, {32, 8, 48, 16}, {48, 8, 64, 16}};
const int32_t LEVEL_2_COLORS[30] = {0x2196F3, 0x4A0904, 0xEBD300, 0xEEF3BC};
const char LEVEL_2_BINDING[30] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3};

const Level LEVELS[25] = {
    {LEVEL_1_BLOCKS, LEVEL_1_COLORS, LEVEL_1_BINDING},
    {LEVEL_2_BLOCKS, LEVEL_2_COLORS, LEVEL_2_BINDING}
};
*/