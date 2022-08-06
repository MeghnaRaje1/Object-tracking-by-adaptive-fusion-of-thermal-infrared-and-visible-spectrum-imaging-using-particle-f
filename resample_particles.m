function [W,X,propied_re]= resample_particles(X ,W,L,Npop_particles,Npix_resolution)
Q=(L)/sum(L,2);
R = cumsum(Q, 2);

N = size(X, 2);
T = rand(1, N);

% Resampling

[~, I] = histc(T, R);

I = I+1;

for k=1:Npop_particles
    if (W(k) < 2)
        W(k)=1./N;
        RandP = randperm(N,1);
        X(:,k)=X(:,I(RandP));
    end
end

[propied_re]=bounding_box_updated(X,Npop_particles,Npix_resolution);
% 
% bbV=propied_re.BoundingBox;
% m=bbV(2);
% n=bbV(1);
% o=(bbV(2)+bbV(4));
% p=(bbV(1)+bbV(3));
% 
% min_y=m;
% max_y=o;
% min_x=n;
% max_x=p;
% 
% G1 = round((max_y-min_y).*rand(1,Npop_particles)+min_y); % normally distributed pseudorandom numbers
% G2 = round((max_x-min_x).*rand(1,Npop_particles)+min_x); % within the bounding box%
% 
% G=[G1;G2];
% 
% for k=1:Npop_particles
%     RandP = randperm(Npop_particles,1);
%     X(1,k)=G(1,RandP);
%     X(2,k)=G(2,RandP);
% end

end