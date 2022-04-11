#define RESP_BASE ( int*) 0x21020
#define GO_BASE ( int*) 0x21040
#define DADOPRT_BASE ( int*) 0x21030
#define M_BASE ( int*) 0x21010
#define N_BASE ( int*) 0x21000

int main()
{
  int resp;
  printf("Hello from Nios II!\n");


  *GO_BASE = 0;
  *GO_BASE = 1;
  *M_BASE = 8;
  *N_BASE = 4;

  while(*DADOPRT_BASE == 0){
	 printf("Teste \n");

  }

  resp = *RESP_BASE;
  printf("Resposta: %d \n",resp);

return 0;
}
