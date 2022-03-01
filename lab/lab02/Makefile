main: Q1.o
	gcc -o main Q1.o
file1: Q1.o
	gcc -o file1 Q1.o
file2: Q2.o
	gcc -o file2 Q2.o
Q1.o: Q1.c
	gcc -c Q1.c
Q2.o: Q2.c
	gcc -c Q2.c
clean:
	rm main Q1.o Q2.o
