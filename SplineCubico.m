function Res = SplineCubico(x,y,C1,CN,xeval,der)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Función destinada a evaluar un spline cubico de clase 2 en una serie de
% puntos. Se requieren vectores verticales.
%
% Argumentos de entrada:
%       x     : Coordenadas x a interpolar (variable independiente), 
%       y     : Coordenadas y a interpolar (variable dependiente), 
%       C1    : Condicion a imponer en el extremo inicial,
%       CN    : Condicion a imponer en el extremo final,
%       xeval : Valores sobre los cuales evaluar el spline.
%       der   : Si der = 0 se evalua el spline, si der = 1 se evalua su
%               derivada primera, si der = 2 se evalua su derivada segunda.
%
% Las condiciones a imponer en los extremos iniciales y finales son:
%     C1 = 'A' : spline anclado (se especifican las derivadas en el
%                inicio; inicialmente el valor seria cero).
%     C1 = 'N' : spline natural (la derivada segunda en el primer nodo se
%                forzaría a ser nula), 
%     C1 = 'K' : spline not-a-knot (se impone la continuidad de la derivada 
%                tercera en el segundo nodo),
%     CN = 'A' : spline anclado (se especifican las derivadas en el
%                fin; inicialmente el valor seria cero).
%     CN = 'N' : spline natural (la derivada segunda en el ultimo nodo se
%                forzaría a ser nula), 
%     CN = 'K' : spline not-a-knot (se impone la continuidad de la derivada 
%                tercera en el antepenultimo nodo),
% 
% Sera necesario tomar una condicion para el inicio y otra para el fin.
% En caso de que deseemos un spline periodico, tendremos que especificar lo
% siguiente:
%     C1 = 'P',         CN = 'P'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Jeronimo Rodriguez
% Departamento de Matemática Aplicada
% Universidade de Santiago de Compostela
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L   = length(xeval);
Res = zeros(L,1);

N     = length(x);
Delta = zeros(1,N-1);
Delta = x(2:end)-x(1:end-1);

C1Bool = 0;
CNBool = 0;

M     = zeros(N,N);
b     = zeros(N,1);
for i = 2:N-1
    M(i,i)   = 2.0/Delta(i) + 2.0/Delta(i-1);
    M(i,i-1) = 1.0/Delta(i-1);
    M(i,i+1) = 1.0/Delta(i);
    b(i)     = 3.0/Delta(i)^2   * (y(i+1) - y(i)) + ...
               3.0/Delta(i-1)^2 * (y(i) - y(i-1));
end

if     C1 == 'A'
    M(1,1) = 1.0;
    b(1)   = 0.0;
    C1Bool = 1;
elseif C1 == 'N'
    M(1,1) = 2.0;
    M(1,2) = 1.0;
    b(1)   = 3.0/Delta(1)^2   * (y(2) - y(1));
    C1Bool = 1;
elseif C1 == 'K'
    M(1,1) =  1.0/Delta(1)^2;
    M(1,2) =  1.0/Delta(1)^2 - 1.0/Delta(2)^2;
    M(1,3) =- 1.0/Delta(2)^2;
    b(1)   =  2.0/Delta(1)^3   * (y(2) - y(1)) - ...
              2.0/Delta(2)^3   * (y(3) - y(2));
	C1Bool = 1;
end

if     CN == 'A'
    M(N,N) = 1.0;
    b(N)   = 0.0;
    CNBool = 1;
elseif CN == 'N'
    M(N,N)   = 2.0;
    M(N,N-1) = 1.0;
    b(N)     = 3.0/Delta(N-1)^2   * (y(N) - y(N-1));
    CNBool = 1;
elseif CN == 'K'
    M(N,N)   =  1.0/Delta(N-1)^2;
    M(N,N-1) =  1.0/Delta(N-1)^2 - 1.0/Delta(N-2)^2;
    M(N,N-2) =- 1.0/Delta(N-2)^2;
    b(N)     =  2.0/Delta(N-1)^3   * (y(N)   - y(N-1)) - ...
                2.0/Delta(N-2)^3   * (y(N-1) - y(N-2));
	CNBool = 1;
end

if C1 == 'P' && CN == 'P'
    M(1,1) =  1.0;
    M(1,N) = -1.0;
    b(1)   = 0.0;
    C1Bool = 1;
    
    M(N,1)   = 4.0/Delta(1);
    M(N,2)   = 2.0/Delta(1);
    M(N,N)   = 4.0/Delta(N-1);
    M(N,N-1) = 2.0/Delta(N-1);
    b(N)     = 6.0/Delta(1)^2     * (y(2) - y(1)) + ...
               6.0/Delta(N-1)^2   * (y(N) - y(N-1));
    CNBool = 1;
end

d = M \ b;


% Coeficientes asociados a los intervalos.
alpha = zeros(1,N-1);
beta  = zeros(1,N-1);
gamma = zeros(1,N-1);
delta = zeros(1,N-1);

alpha = y(1:end-1);
beta  = d(1:end-1);
gamma = ((y(2:end) - y(1:end-1)) ./ Delta - d(1:end-1)) ./ Delta;
delta = (d(1:end-1) + d(2:end) - 2 * (y(2:end) - y(1:end-1)) ./ Delta) ./ Delta.^2;

if     der == 0
    index = zeros(L,1);
    for k = 1:L
        index(k) = max(find(x(1:end-1) <= xeval(k)));
        Res(k)   = alpha(index(k)) + ...
                   beta (index(k)) * ( xeval(k) - x(index(k)))   + ...
                   gamma(index(k)) * ( xeval(k) - x(index(k)))^2 + ...
                   delta(index(k)) * ( xeval(k) - x(index(k)))^2 * ...
                                     ( xeval(k) - x(index(k)+1)) ;
    end
elseif der == 1
    index = zeros(L,1);
    for k = 1:L
        index(k) = max(find(x(1:end-1) <= xeval(k)));
        Res(k)   = beta(index(k)) + ...
               2 * gamma(index(k)) *   (xeval(k) - x(index(k))) + ...
                   delta(index(k)) * ( (xeval(k) - x(index(k)))^2 + ...
                                   2 * (xeval(k) - x(index(k))) * ...
                                       (xeval(k) - x(index(k)+1))); 
    end
elseif der == 2
    index = zeros(L,1);
    for k = 1:L
        index(k) = max(find(x(1:end-1) <= xeval(k)));
        Res(k)   = 2 * gamma(index(k)) + ...
                   2 * delta(index(k)) * ...
                      ( 2 * (xeval(k) - x(index(k))) + ...
                            (xeval(k) - x(index(k)+1))); 
    end
else
    warning('Value for der not implemented.')
end

end