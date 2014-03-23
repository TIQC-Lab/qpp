TARGET = qpp # Application name
SRC = ./src# no white spaces allowed before the comment!
INC = ./include# no white spaces allowed before the comment!

CC_STANDARD = -std=c++11 # C++ standard, we use C++11
CC = g++ # C++ compiler
WARNINGS = -Wall -Wextra # Extra warnings
MULTIPROC = -fopenmp # Use OPENMP for multi-processing 
OPTIM = -mtune=native -msse3 # use SSE2 and Native compiling

EIGEN = ~/eigen_3.2.1 # Location of Eigen library, replace it with your own

# Some flags, use pedantic for C++ standard compliance
CFLAGS = -c -pedantic $(CC_STANDARD) $(WARNINGS) $(MULTIPROC) $(OPTIM)\
	-isystem $(EIGEN) -I $(INC)
CFLAGS_RELEASE = -O3 -DNDEBUG -DEIGEN_NO_DEBUG # Release flags
CFLAGS_DEBUG = -DDEBUG -g3 # Debug flags

# Use gomp multi-processing library
LDFLAGS = -lgomp

SOURCES = $(wildcard $(SRC)/*.cpp)
OBJECTS = $(SOURCES:.cpp=.o)

# Default make configuration is release
all: release

# Release make configuration
release: CFLAGS += $(CFLAGS_RELEASE) 
release: $(SOURCES) $(TARGET)

# Debug make configuration
debug: CFLAGS += $(CFLAGS_DEBUG)
debug: $(SOURCES) $(TARGET) 


$(TARGET): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

# Clean-up
clean:
	@echo 'Removing...'
	@rm -fv $(SRC)/*.o 
	@rm -fv $(TARGET)
