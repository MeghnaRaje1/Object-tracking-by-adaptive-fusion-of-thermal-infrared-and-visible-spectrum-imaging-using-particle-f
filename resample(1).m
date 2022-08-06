
function [X,W]= resample(X ,W,Npop_particles,propied)

%cc=propied.Centroid;

Wn=zeros(1,Npop_particles);
Wn1=[];

bbV=propied.BoundingBox;
m=bbV(2);
n=bbV(1);
o=(bbV(2)+bbV(4));
p=(bbV(1)+bbV(3));
count=0;
for k=1:Npop_particles
    if W(k)>5
        Wn(k)=W(k);
        
    end
    
end
display(Wn);

v=1;
for j=1:Npop_particles
    if(Wn(1,j)~= 0 )
        Wn1(1,v)=Wn(1,j);
        v = v+1;
        
    end
end
display(Wn1);

particle_gene=Npop_particles-count;
if(particle_gene ~=0)
    min_y=m;
    max_y=o;
    min_x=n;
    max_x=p;
    display(min_x);
    display(max_x);
    display(min_y);
    display(max_y);
    
    G1 = round((max_y-min_y).*rand(1,particle_gene)+min_y); % normally distributed pseudorandom numbers
    G2 = round((max_x-min_x).*rand(1,particle_gene)+min_x); % within the bounding box%
    
    G=[G1;G2];
    
    [m1,n2]=size(G);
    display(G);
    display(count);
    
    [m2,n3]=size(Wn1);
    %Rand_numb = randn(1,n2);
    
    
    for k=1:Npop_particles
        %     I = ~(X(1,k) <= max_y & X(1,k) >= min_y);
        %     J = ~(X(2,k) <= max_x & X(2,k) >= min_x);
        
        RandP = randperm(n2,1);
      
        %    display(RandP);
        
        if W(k)<5
            X(1,k)=G(1,RandP);
            X(2,k)=G(2,RandP);
            
            %         display(X(1,k));
        end
        if W(k)<5
            W(k)=1/Npop_particles;
        end
    end
end
display(X);
end
