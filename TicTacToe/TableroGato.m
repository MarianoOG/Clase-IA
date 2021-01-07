clc, clear all, close all;
Gato = zeros(1,9);
Orden=1;
Findeljuego=1;
VectorD=[8,4,7,3,9,2,6,1,5]/100+100;
PrimeraVez=1;
%=========================================================================
if(PrimeraVez==0)
    Caso1=zeros(1,9);
    %=====================================================================
    Caso2=zeros(1,9);
    Escojer2=zeros(1,9);
    Caso4=zeros(1,9);
    Escojer4=zeros(1,9);
    Caso6=zeros(1,9);
    Escojer6=zeros(1,9);
    Caso8=zeros(1,9);
    Escojer8=zeros(1,9);
else    
    load Caso2
    load Escojer2    
    load Caso4
    load Escojer4
    load Caso6
    load Escojer6
    load Caso8
    load Escojer8
end
%=========================================================================
i=0;
j=0;
k=0;
l=0;
Posi2=0;
Posi4=0;
Posi6=0;
Posi8=0;
%%%Modelo de juego para 2 personas:

%%%%Colocar primer pieza   
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            
            A=input('Ingrese la posici?n:');
            Gato=PonerM(Gato,A);
    end
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
%%%%Colocar segunda pieza

    switch ( mod(Orden,2) )
        case {1}
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0}
            HUBO=0;
            for i=1:size(Caso2,1)
                Cs=isequal(Gato,Caso2(i,:));
                if (Cs==1) %%Si lo encontramos
                       HUBO = i;
                       Vale = (Gato<1);
                       [numero,Posi] = max(Escojer2(i,:).*Vale );
                       A = Posi;
                       Posi2 = Posi;
                       i=i-1;
                else 
                    if (Cs==0 && i==size(Caso2,1) && HUBO==0)
                        Caso2    = [Caso2;Gato];
                        Escojer2 = [Escojer2;VectorD];
                        Vale=(Gato<1);
                        [numero,Posi]=max(Escojer2(i+1,:).*Vale );
                        A=Posi;
                        Posi2=Posi;                    
                    end                
                end
            end
            i=HUBO;
            Gato=PonerM(Gato,A);
    end    
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;    
%%%%Colocar tercer pieza
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            A=input('Ingrese la posici?n:');
            Gato=PonerM(Gato,A);
    end    
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
%%%%Colocar cuarta pieza
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            HUBO=0;
            for j=1:size(Caso4,1)
                Cs=isequal(Gato,Caso4(j,:));
                if (Cs==1) 
                        HUBO=j;
                        Vale=(Gato<1);
                       [numero,Posi]=max(Escojer4(j,:).*Vale );
                       A=Posi;
                       Posi4=A;
                       j=j-1; 
                else
                    if (Cs==0 && j==size(Caso4,1) &&  HUBO==0)
                        Caso4    = [Caso4;Gato];
                        Escojer4 = [Escojer4;VectorD];
                        Vale=(Gato<1);
                        [numero,Posi]=max(Escojer4(j+1,:).*Vale );
                        A=Posi;
                        Posi4=Posi;
                    end
                end
            end
            j=HUBO;
            Gato=PonerM(Gato,A);
    end
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
%%%%Colocar quinta pieza
    
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            A=input('Ingrese la posici?n:');
            Gato=PonerM(Gato,A);
    end    
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
    %%Validar victoria
    Findeljuego=validador(Gato,Orden);
%%%%Colocar sexta pieza
if (Findeljuego==0)
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            HUBO=0;
            for k=1:size(Caso6,1) %%Recorremos el ancho de Caso2
                Cs=isequal(Gato,Caso6(k,:)); %%Buscamos el caso
                
                if (Cs==1) %%Si lo encontramos
                       HUBO=k;
                       Vale=(Gato<1); %%Obtenemos el vector que nos dice que casos podemos usar //L?mite de 0
                       %%El producto hace 0 a aquellos lugares que no puedes
                       %%ser elegidos
                       [numero,Posi]=max(Escojer6(k,:).*Vale ); %%%Buscamos el m?ximo en la lista y obtenemos su posicion
                       A=Posi; %La posicion donde diga es donde escribiremos en el gato :v
                       Posi6=A;
                       k=k-1; %%Correccion de desfase al encontrarlo                       
                else
                    if (Cs==0 && k==size(Caso6,1) && HUBO==0) %%Si no lo encontramos y llegamos al final
                        Caso6    = [Caso6;Gato]; %%Se agrega a los casos de decision
                        Escojer6 = [Escojer6;VectorD]; %%Se crea su respectivo escojer donde i representa el caso

                        %%%De igual forma, al no encontrarlo asignamos el valor
                        %%%para este caso:
                        Vale=(Gato<1);
                        [numero,Posi]=max(Escojer6(k+1,:).*Vale ); %%%Buscamos el m?ximo en la lista y obtenemos su posicion
                        A=Posi; %La posicion donde diga es donde escribiremos en el gato :v
                        Posi6=Posi;
                    end                
                end 
                
            end                        
            k=HUBO;
    
            Gato=PonerM(Gato,A);
    end    
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
    %%Validar victoria
    Findeljuego=validador(Gato,Orden);
end
%%%%Colocar septima pieza
if(Findeljuego==0)
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            A=input('Ingrese la posici?n:');
            Gato=PonerM(Gato,A);
    end
    
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
    %%Validar victoria
    Findeljuego=validador(Gato,Orden);
end
%%%%Colocar octava pieza
if(Findeljuego==0)
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            HUBO=0;
            for l=1:size(Caso8,1) %%Recorremos el ancho de Caso2
                Cs=isequal(Gato,Caso8(l,:)); %%Buscamos el caso
                if (Cs==1) %%Si lo encontramos
                       HUBO=l;
                       Vale=(Gato<1); %%Obtenemos el vector que nos dice que casos podemos usar //L?mite de 0
                       %%El producto hace 0 a aquellos lugares que no puedes
                       %%ser elegidos
                       [numero,Posi]=max(Escojer8(l,:).*Vale ); %%%Buscamos el m?ximo en la lista y obtenemos su posicion
                       A=Posi; %La posicion donde diga es donde escribiremos en el gato :v
                       Posi8=A;
                       l=l-1; %Correccion de desfase al encontrarlo
                else
                    if (Cs==0 && l==size(Caso8,1) && HUBO==0) %%Si no lo encontramos y llegamos al final
                        Caso8    = [Caso8;Gato]; %%Se agrega a los casos de decision
                        Escojer8 = [Escojer8;VectorD]; %%Se crea su respectivo escojer donde i representa el caso

                        %%%De igual forma, al no encontrarlo asignamos el valor
                        %%%para este caso:
                        Vale=(Gato<1);
                        [numero,Posi]=max(Escojer8(l+1,:).*Vale ); %%%Buscamos el m?ximo en la lista y obtenemos su posicion
                        A=Posi; %La posicion donde diga es donde escribiremos en el gato :v
                        Posi8=Posi;
                    end                
                end 
                
            end
            l=HUBO;
            Gato=PonerM(Gato,A);
    end
    
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
    %%Validar victoria
    Findeljuego=validador(Gato,Orden);
end
%%%%Colocar novena pieza
if(Findeljuego==0)
    switch ( mod(Orden,2) )
        case {1} %Persona
            A=input('Ingrese la posici?n:');
            Gato=PonerU(Gato,A);
        case {0} %Computadora
            A=input('Ingrese la posici?n:');
            Gato=PonerM(Gato,A);
    end
    
    [Gato(1:3);Gato(4:6);Gato(7:9)]
    Orden=Orden+1;
    
    %%Validar victoria
    T=validador(Gato,Orden);
    Findeljuego=T;
    if (T==3)
        disp('Empate, la casa gana')
    end
end

if(Findeljuego~=0) %%%Aqu? hacemos el alterador de casos
    if(i~=0 && Posi2~=0)        
        if(Findeljuego==1)
                %%Gan? el usuario            
               % Escojer2(i,Posi2)=Escojer2(i,Posi2)-0.5; %%Se uso estedato        
        else
            if(Findeljuego==2) 
                %%Gano la chompu
                %Escojer2(i,Posi2)=Escojer2(i,Posi2)+1; %%Se uso estedato        
            else
                %%Entonces vale 3 y fue empate
                %Escojer2(i,Posi2)=Escojer2(i,Posi2)+0.5; %%Se uso estedato        
            end
        end
        Escojer2;
    end
    if(j~=0 && Posi4~=0)              
        if(Findeljuego==1)
                %%Gan? el usuario            
                Escojer4(j,Posi4)=Escojer4(j,Posi4)-0.25/(Orden-4)/4; %%Se uso estedato  
        else
            if(Findeljuego==2) 
                %%Gano la chompu
                Escojer4(j,Posi4)=Escojer4(j,Posi4)+0.5/(Orden-4)/4; %%Se uso estedato  
            else
                %%Entonces vale 3 y fue empate
                Escojer4(j,Posi4)=Escojer4(j,Posi4)+0.12/(Orden-4)/4; %%Se uso estedato  
            end
        end
        Escojer4;
    end
    if(k~=0 && Posi6~=0)
        if(Findeljuego==1)
                %%Gan? el usuario            
                Escojer6(k,Posi6)=Escojer6(k,Posi6)-0.25/(Orden-4)/2; %%Se uso estedato        
        else
            if(Findeljuego==2) 
                %%Gano la chompu
                Escojer6(k,Posi6)=Escojer6(k,Posi6)+0.5/(Orden-4)/2; %%Se uso estedato        
            else
                %%Entonces vale 3 y fue empate
                Escojer6(k,Posi6)=Escojer6(k,Posi6)+0.12/(Orden-4)/2;; %%Se uso estedato        
            end
        end
        Escojer6;
    end
    if(l~=0 && Posi8~=0)
        
        if(Findeljuego==1)
                %%Gan? el usuario            
                Escojer8(l,Posi8)=Escojer8(l,Posi8)-0.25/(Orden-4); %%Se uso estedato        
        else
            if(Findeljuego==2) 
                %%Gano la chompu
                Escojer8(l,Posi8)=Escojer8(l,Posi8)+0.5/(Orden-4); %%Se uso estedato        
            else
                %%Entonces vale 3 y fue empate
                Escojer8(l,Posi8)=Escojer8(l,Posi8)+0.12/(Orden-4); %%Se uso estedato        
            end
        end
        Escojer8;
    end
end
    save('Escojer2','Escojer2');
    save('Caso2','Caso2');            
    
    save('Escojer4','Escojer4');
    save('Caso4','Caso4');            
    
    save('Escojer6','Escojer6');
    save('Caso6','Caso6');                

    save('Escojer8','Escojer8');
    save('Caso8','Caso8');            
    
    