function [W]=importance_weight(W,L,Npop_particles)
 W_sum=sum(sum(W));
W_prev=W;

    
    for k=1:Npop_particles
 %X(1,l)=1./Npop_particles;
   W(k)=(W_prev(k)'*L(k));
  
    end


% for k=1:4
%     for l=1:Npop_particles
%         Z(k,l)=X(k,l)/W_sum;
%     end
% end
