#include "main.h"

int main(int argc, char* argv[]) {
   
   correr_tests(argc, argv[1]);    //solo corre si argv es "test"
  
   while(1){
      sleep(2);
      helloWorld();
   }
   
}