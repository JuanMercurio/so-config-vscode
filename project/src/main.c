#include "main.h"


int main(int argc, char* argv[]) {
   
   //solo corre si corremos el binario asi: binario test
   correr_tests(argc, argv[1]);    
   
   while(1){
      helloWorld();
      sleep(2);
   }

   int saturno;
   
   return 0;
}
