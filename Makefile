# Compiler
CXX = g++

# Directories
SRC_DIR = ./src
INCLUDE_DIR = ./include
BUILD_DIR = ./build
BIN_DIR = .
#NTL_DIR = ./sw

# Files
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))
DEPS = $(wildcard $(INCLUDE_DIR)/*.h)

# Compiler flags
CXXFLAGS=-std=c++11 -g -fopenmp -Wall -Wextra -I$(INCLUDE_DIR) #-I$(NTL_DIR)/include -L$(NTL_DIR)/lib

# Linker flags
LDLIBS=-lntl -lgmp -lm -fopenmp -lstdc++fs 

# Target executable
TARGET = $(BIN_DIR)/main

# Phony targets
.PHONY: all clean

# Default target
all: $(TARGET)

# Compilation
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp $(DEPS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Linking
$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDLIBS)

$(TEST): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $(SRC_DIR)/test.cpp $^ -o $@ $(LDLIBS)

clean:
	$(RM) *.o *.d $(TARGET)
