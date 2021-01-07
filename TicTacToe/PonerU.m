function[Gato]=PonerU(Gato,A) %%Las entradas son el tablero y la posicion
                               %Las salidas es el tablero
error=0;
while(error==0)
    
    if(A>=10)
        disp('Esa casilla no pertenece al tablero')
        A=input('Ingrese la posición:');
        error=0;
    else
        if(Gato(A)==1 ||Gato(A)==2)
            disp('Esa casilla ya está ocupada')
            A=input('Ingrese la posición:');
            error=0;
        else
            error=1;
        end
    end
end
Gato(A)=1;
end
                         
