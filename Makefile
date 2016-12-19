CC= g++
CFLAGS = -O3 
#CFLAGS = -ggdb

INCS = `pkg-config --cflags opencv` 
LIBS = `pkg-config --libs opencv`

OBJS = OpenCVUtils.o Region.o RegionsSingleImage.o EllipseR.o EllipsesSingleImage.o RectangleR.o RectanglesSingleImage.o Hungarian.o MatchPair.o Matching.o Results.o evaluate.o
BIN = evaluate

all : $(BIN)

evaluate: $(OBJS)
	$(CC) $(OBJS) -o $@ $(LIBS)

%.o:%.cpp
	$(CC) $(CFLAGS) $(INCS) -c $< 

%.cpp:%.hpp
	touch $@

Matching.hpp: RegionsSingleImage.hpp MatchPair.hpp
	touch $@

evaluate.cpp: RegionsSingleImage.hpp Matching.hpp common.hpp
	touch $@

RegionsSingleImage.hpp: common.hpp
	touch $@

clean:
	rm -f $(OBJS) $(BIN)

tarFile:
	mkdir evaluation
	cp EllipseR.hpp EllipseR.cpp evaluation
	cp EllipsesSingleImage.hpp EllipsesSingleImage.cpp evaluation
	cp Hungarian.hpp Hungarian.cpp evaluation
	cp MatchPair.hpp MatchPair.cpp evaluation
	cp Matching.hpp Matching.cpp evaluation
	cp OpenCVUtils.hpp OpenCVUtils.cpp evaluation
	cp RectangleR.hpp RectangleR.cpp evaluation
	cp RectanglesSingleImage.hpp RectanglesSingleImage.cpp evaluation
	cp Region.hpp Region.cpp evaluation
	cp RegionsSingleImage.hpp RegionsSingleImage.cpp evaluation
	cp Results.hpp Results.cpp evaluation
	cp common.hpp evaluate.cpp evaluation
	cp runEvaluate.pl Makefile evaluation
	cp README.txt evaluation
	tar -czf evaluation.tgz evaluation
	rm -rf evaluation
	
