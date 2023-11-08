{
===============================================================================================
= Nome: Andre Rafael Sousa Teixeira n:2 12.A                                                    =
= Disciplina: Aplicacoes Informaticas B                                                         =
===============================================================================================
}

program analise_financeira;

uses crt;

type
	valores = array[1..4,1..2] of real;  
	indexes = array[1..2] of integer; // 1-semana 2-mes
const
	  _vendas = 'vendas';
	  _custos = 'custos';
		  
var nome_empresa,nome_produto:string;
	  balanco,vendas,custos:valores;
		op:char;

function maximo_arr(arr:valores):indexes;
var
	 max:real;
	 semana,semanaMax,mesMax,mes:integer;
	 retorno:indexes; 
begin
	 max := arr[1,1];
	 semanaMax := 1;
	 mesMax := 1;
	 for mes := 1 to 2 do
	 		for semana:= 1 to 4 do
	 			begin
	 				  if arr[semana,mes] > max then
						 	begin
							    max := arr[semana,mes];
							    semanaMax := semana;
							    mesMax := mes;
							end; 
	 			end;
		retorno[1] := semanaMax;
		retorno[2] := mesMax;
		maximo_arr := retorno;	 		
end;

function minimo_arr(arr:valores):indexes;
var
	 min:real;
	 semana,semanaMin,mesMin,mes:integer;
	 retorno:indexes;
begin
	 min := arr[1,1];
	 semanaMin := 1;
	 mesMin := 1;
	 for mes := 1 to 2 do
	 		for semana:= 1 to 4 do
	 			begin
	 				  if arr[semana,mes] < min then
						 	begin
							    min := arr[semana,mes];
							    semanaMin := semana;
							    mesMin := mes;
							end; 
	 			end;
	 	retorno[1] := semanaMin;
	 	retorno[2] := mesMin;
		minimo_arr := retorno; 		
end;

procedure valores_semanais(arr:valores;tipo:string);
var
	mes:integer;
	semana:integer;
begin
	  writeln('Qual e o mes ?');
	  readln(mes);
	  writeln('No mes ',mes);
		writeln;
		for semana:= 1 to 4 do
			begin
			    writeln('Na semana ',semana,' ',tipo,'= ',arr[semana,mes]:4:2,' euros');
			    readln;
			end;
end;

function somar_mensal(arr:valores;mes:integer):real;
var
	semana:integer;
	soma:real;
begin
	 for semana:=1 to 4 do
	 	soma := soma + arr[semana,mes];
	 somar_mensal:= soma;
end;

procedure total_Mensal(arr:valores;tipo:string);
var
	 semana:integer;
	 mes:integer;
begin
	  
	  writeln('Qual e o mes ?');
	  readln(mes);
	  writeln('No mes ',mes,' o total de ',tipo,' e ',somar_mensal(arr,mes):4:2,' euros');
	  	
end;
function total(arr:valores):real;
begin
	 total := somar_mensal(arr,1) + somar_mensal(arr,2);
end;

function media(arr:valores):real;
begin
		media := total(arr)/8;
end;

procedure calcularBalancos;
	var semana,mes:integer;
begin
	for mes := 1 to 2 do
		for semana := 1 to 4 do
			balanco[semana,mes] := vendas[semana,mes] - custos[semana,mes];		 
end;

procedure menu;
begin
	TextColor(White);
	writeln('Empresa: ',nome_empresa, ' Produto: ',nome_produto);
	writeln;
	writeln;
	TextColor(Red);
	writeln('    #############################################################  ');
	writeln('    #                     Analise financeira                    #  ');
	writeln('    #####                                                   #####  ');
	writeln('    #             Escolha uma opcao(prima s para sair)          #  ');
	writeln('    #############################################################  ');
	writeln(' ##################################################################');
	writeln('#  1- Vendas semanais | 7- Custos semanais |  d- Balanco semanal    #');
	writeln('#  2- Total vendas mensal|8-Total custos mensal|e-Balanco mensal    #');
	writeln('#  3- Total das vendas|9-Total dos custos|f-Balanco Total           #');
	writeln('#  4- Media das vendas|a-Media dos custos|g- Media total            #');
	writeln('#  5- Maximo das vendas|b-Maximo dos custos|h-Maximo                #');
	writeln('#  6- Minimo das vendas|c-Minimo dos custos|i-minimo                #');         
	writeln(' ###################################################################');    
	TextColor(Green);
end;
procedure balanco_semanal;
var
	mes,semana:integer;
begin
	writeln('Insira o mes e a semana(mes semana)');
	readln(mes,semana);
	if(balanco[semana,mes] >= 0) then
		writeln('Na semana ',semana,' do mes ',mes,' o balanco foi de ',balanco[semana,mes]:4:2,' euros . Parabéns a sua empresa está a subir.')
	else
		writeln('Na semana ',semana,' do mes ',mes,' o balanco foi de ',balanco[semana,mes]:4:2,' euros . É favor de vender mais da próxima vez.'); 
end;
procedure balanco_mensal;
var
	 mes:integer;
	 total_m:real;
begin
		writeln('Insira o mes ');
		readln(mes);
		total_m := somar_mensal(balanco,mes);
		if total_m >= 0 then
			writeln('No mes ',mes,' o balanco foi de ',total_m:0:2,' euros. Parabens a sua empresa está a subir.')
		else
			writeln('No mes ',mes,' o balanco foi de ',total_m:0:2,' euros. E favor de vender mais da próxima vez.');
		
end;
procedure balanco_total;
var
	total_t:real;
begin
   total_t := total(balanco);
   if total_t >= 0 then
   	writeln('O balanco total e de ',total_t:4:2,' euros. Parabens a sua empresa esta a subir. ')
  else
  	writeln('O balanco total e de ',total_t:4:2,' euros. E favor de vender mais da proxima vez.');
end;

procedure media_balanco;
var
	media_m:real;
begin
	media_m:= media(balanco);
	if media_m >= 0 then
		writeln('O balanco medio e de ',media_m:4:2,' euros. Parabéns a sua empresa esta a subir.')
	else
		writeln('O balanco medio e de ',media_m:4:2,' euros. E favor de vender mais da proxima vez.');
end;

procedure maximo_balanco;
var
	maximo:indexes;
	valor:real;
begin
	maximo := maximo_arr(balanco);
	valor := balanco[maximo[1],maximo[2]];
	if valor >= 0 then
		writeln('Na semana ',maximo[1],' do mes ',maximo[2], ' o balanco maximo foi de ',valor,' euros. Parabens a sua empresa esta a subir')
	else
		writeln('Na semana ',maximo[1],' do mes ',maximo[2], ' o balanco maximo foi de ',valor,' euros no entanto houve prejuizo por isso e importante aumentar o numero de vendas'); 	
end;

procedure minimo_balanco;
var
	minimo:indexes;
	valor:real;
begin
	minimo := minimo_arr(balanco);
	valor := balanco[minimo[1],minimo[2]];
	if valor >= 0 then
		writeln('Na semana ',minimo[1],' do mes ',minimo[2], ' o balanco minimo foi de ',valor:4:2,' euros. Parabens a sua empresa esta a subir')
	else
		writeln('Na semana ',minimo[1],' do mes ',minimo[2], ' o balanco minimo foi de ',valor:4:2,' euros no entanto houve prejuizo por isso e importante aumentar o numero de vendas'); 	
end;

procedure maximo_tipo(arr:valores;tipo:string);
var
	i:indexes;
	valor:real;
begin
	i := maximo_arr(arr);
	valor := arr[i[1],i[2]];
	writeln('Na semana ',i[1],' do mes ',i[2],' foi o momento maximo de ',tipo, '  com valor de ',valor:4:2, ' euros');
end;

procedure minimo_tipo(arr:valores;tipo:string);
var
	i:indexes;
	valor:real;
begin
	i := minimo_arr(arr);
	valor := arr[i[1],i[2]];
	writeln('Na semana ',i[1],' do mes ',i[2],' foi o momento minimo de ',tipo,' com valor de ',valor:4:2,' euros');
end;

procedure escolha;
begin
		writeln;
		write('>> ');
	  readln(op);
	  clrscr;
	  case op of
	  '1':valores_semanais(vendas,_vendas);
	  '7':valores_semanais(custos,_custos);
	  'd':balanco_semanal;
	  '2':total_mensal(vendas,_vendas);
	  '8':total_mensal(custos,_custos);
	  'e':balanco_mensal;
	  '3':writeln('A total das venda e de ',total(vendas):4:2,' euros');
	  '9':writeln('O total dos custos e de ',total(custos):4:2,' euros');
	  'f':balanco_total;
	  '4':writeln('A media das vendas e de ',media(vendas):4:2,' euros');
	  'a':writeln('A media dos custos e de ',media(custos):4:2,' euros');
	  'g':media_balanco;
	  '5':maximo_tipo(vendas,_vendas);
	  'b':maximo_tipo(custos,_custos);
		'h':maximo_balanco;
		'6':minimo_tipo(vendas,_vendas);
	  'c':minimo_tipo(custos,_custos); 
	  'i':minimo_balanco;
	  else
	  	if op <> 's' then
	  		writeln('Opcao invalida');
		end;
		
		if op <> 's' then
		begin		
	  	writeln;
	  	writeln('Prima enter para continuar...');
	  	readln;
	  end;	
	  clrscr;
	  	
end;
 
procedure definir_empresa;
begin
	 writeln('Qual e a empresa ?');
	 readln(nome_empresa);
	 writeln('Qual o produto que comercializa ?');
	 readln(nome_produto);
	 clrscr;
end;

function registar_valores(arr:valores;tipo:string):valores;
var
	mes:integer;
begin
		for mes:=1 to 2 do
			begin
				 TextColor(White);
			   writeln('Registe os ',tipo,' do mes ',mes);
			   TextColor(Red);
			   readln(arr[1,mes],arr[2,mes],arr[3,mes],arr[4,mes]);
			   
			end;                                                                                               
		registar_valores := arr;
end;
procedure inserir_dados;
begin
	 vendas := registar_valores(vendas,_vendas);
	 clrscr;
	 custos := registar_valores(custos,_custos);
	 clrscr;
	 calcularBalancos;	 
end;

begin
		definir_empresa;
		inserir_dados;
		repeat
				menu;
			  escolha;
		until(op = 's');
		writeln('Obrigado por utilizar o programa!! Volte sempre');
end.	  	 