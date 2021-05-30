CHECKERS=  \
	fullequirec \
	fullfomsubisorecref \
	fullisorec \
	fullomega \
	fullref \
	fulluntyped \
	fulluntypedref

all: 
	for ch in ${CHECKERS}; do \
	  (cd $$ch; echo "Compiling $$ch"; ${MAKE}); \
	done

clean-all:
	for ch in ${CHECKERS}; do \
          (cd $$ch; ${MAKE} clean); \
	done

.PHONY: all clean-all
