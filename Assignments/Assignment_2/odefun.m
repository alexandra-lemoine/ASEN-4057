phi = 50
thet = 25
psi = 70


DCM = C3(psi) * C2(thet) * C1(phi)
dtr = pi/180;
rtd = 1/dtr;

[evec,eval] = eig(DCM1,'vector')
[~,i] = max(real(eval))
u = evec(:,i)

[~,i] = max(imag(eval));
phi = angle(eval(1))
phid = phi*rtd


ut = cross(u,u)
Cplus = cos(phi)*eye(3) + (1 - cos(phi))*u*u' - sin(phi)* ut
Cminus = cos(-phi)*eye(3) + (1 - cos(-phi))*u*u' - sin(-phi)* ut
DCM1