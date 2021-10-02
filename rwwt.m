function [G]=rwwt(A2,B2,lor,lhr)

AA2=[];
BB2=[];
AA=[];
BB=[];
C=[];
G=[];


AA2=A2;
BB2=B2;

L=length(lor);
N=2*length(A2);
res=rem(L,N);
co=floor(L/N);

for i=1:co
   AA2=[A2 AA2 A2];
   BB2=[B2 BB2 B2];
end;

AA=[A2(floor((N-(res-1))/2)+1:length(A2)) AA2 A2(1:floor((res-1)/2))];
BB=[B2(floor((N-(res-1))/2)+1:length(B2)) BB2 B2(1:floor((res-1)/2))];

if L<N
   D=L;
else
   D=N;
end;   
%AA=AA*D;
%BB=BB*D;

[C]=idwt(AA,BB,lor,lhr);


if res==0
   fac=1;
else
   fac=0;
end;

r=3+fac;
G=C(r+1:r+N);

