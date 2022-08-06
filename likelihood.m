function L = likelihood(propied,ssim_val,ssim_map,ssim_Particle, X, Y) %#codegen

% Npix_h = size(Y, 1);
% Npix_w = size(Y, 2);

bb=propied.BoundingBox;

% display(c);
% display(bb);

recw=bb(4);
rech=bb(3);
N = size(X,2);

% % std_dev=std(ssim_map);
% for i=1:254
%     for j=1:328
% std_dev=sqrt((1/((254*328)-1))*square(abs(ssim_map(i,j)-ssim_val)));
%     end 
% end
% disp('------%%%%---------');

% display(std_dev);
% const=1/sqrt(2*pi*std_dev);
% display(const);

L = zeros(1,N);
Y = permute(Y, [3 1 2]);

for k = 1:N
    Dssim_map=ssim_Particle(k);
       Dssim_min=min(ssim_Particle);
%         display(Dssim_min);
%             display(L);

A = (-(Dssim_map' * Dssim_map));
B = (Dssim_min' * Dssim_min);

% A = -Dssim_map;
% B = Dssim_min;

X = round(X);
    
    m = X(1,k);
    n = X(2,k);
    
%     I = (m >= 1 & m <= rech);
%     J = (n >= 1 & n <= recw);
%     
%     if I && J
%        
        L(k) =( exp(A./B));

%     else
%         L(k) = Inf;
%     end
end


% max_like=max(L);
% for i=1:260
%     if L(i)==max_like
%         x_rep=X(2,k);
%         y_rep=X(2,k);
%     end
% end
% 
% for i=1:260
%     if(L(i)<0.7)
%         L(i)=max_like;
%         X(1,i)=x_rep;
%         X(2,i)=y_rep;
%         
%     end
% end
