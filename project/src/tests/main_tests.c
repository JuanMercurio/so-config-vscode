#include "tests.h"

/*
    @NAME: run_tests
    @DESC: Funcion principal que corre los tests
 */
int run_tests(){

    CU_initialize_registry();
   
    CU_pSuite tests = CU_add_suite("PROCESO3 Suite",NULL,NULL);
    CU_add_test(tests,"Probar Suma", suma);

    CU_basic_set_mode(CU_BRM_VERBOSE);
    CU_basic_run_tests();
    CU_cleanup_registry();

    return CU_get_error();
}

/*
    @NAME: correr_tests
    @DESC: Se encarga de ver si el usuario quiere hacer tests o correr programa normalmente
    @PARA: arg  - cantidad de paramentros que inserto el usuario
           argv - el primer parametros que inserto el usuario  
 */
void correr_tests(int arg, char* argv){
    if(arg > 1 && strcmp(argv, "test")==0){
        int a = run_tests();
        exit(a);
    }
}

void suma(){
    CU_ASSERT_EQUAL(2+2, 4);
}