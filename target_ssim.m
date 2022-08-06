function X=target_ssim(ssim_map,X,Npop_particles,th)



[r,c]=find(ssim_map<th);

X1=[r,c];
X1=X1';
% display(X1);

[m2,n2]=size(X1);
Rand_numb = (randi(n2,1,n2));
for k=1:Npop_particles
 
        RandP = randperm(n2,1);
        
            X(1,k)=X1(1,RandP);
            X(2,k)=X1(2,RandP);
        
 
end


  