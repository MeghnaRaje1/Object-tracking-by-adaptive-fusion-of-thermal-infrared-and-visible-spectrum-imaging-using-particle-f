function X=create_particle(propied,Npop_particles)

c=propied.Centroid;
bb=propied.BoundingBox;

% display(c);
% display(bb);

recw=bb(4);
rech=bb(3);


X1 = randn(1,Npop_particles)*recw/4+ c(2)*ones(1,Npop_particles); % normally distributed pseudorandom numbers                                              
X2 = randn(1,Npop_particles)*rech/4+c(1)*ones(1,Npop_particles); % within the bounding box%

X3 = zeros(2, Npop_particles); % significance of this is shown in resample_particles

X = [floor(X1); floor(X2); X3];
