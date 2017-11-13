domsize=1;
dx=0.05; dt=0.1;

D1=0.0002; D2=0.01; #diffusion coefficients

endtime=50;

function f(u,v)
    return 0.6*u-v-u^3
end

function g(u,v)
    return 1.5*u-2*v
end

N=round(Int,domsize/dx);
R=round(Int,endtime/dt); #Number of repetitions
p=zeros(R+1,N); #init activator values
p[1,:]=rand(1,N)*0.1;
q=zeros(R+1,N); #init inhibitor values
q[1,:]=rand(1,N)*0.5;



for t=1:R
    #Zero-flux boundary conditions
    p[t+1,1]=p[t,1]+(f(p[t,1],q[t,1])+D1*(p[t,2]-p[t,1])/dx/dx)*dt;
    q[t+1,1]=q[t,1]+(g(p[t,1],q[t,1])+D1*(q[t,2]-q[t,1])/dx/dx)*dt;
    p[t+1,N]=p[t,N]+(f(p[t,N],q[t,N])+D1*(p[t,N-1]-p[t,N])/dx/dx)*dt;
    q[t+1,N]=q[t,N]+(g(p[t,N],q[t,N])+D1*(q[t,N-1]-q[t,N])/dx/dx)*dt;

    for i=2:(N-1)
        p[t+1,i]=p[t,i]+(f(p[t,i],q[t,i])+D1*(p[t,i+1]+p[t,i-1]-2*p[t,i])/dx/dx)*dt;
        q[t+1,i]=q[t,i]+(g(p[t,i],q[t,i])+D2*(q[t,i+1]+q[t,i-1]-2*q[t,i])/dx/dx)*dt;
    end
end

ENV["MPLBACKEND"]="qt4agg";
using PyPlot
#using Plots
x=1:N;
y=p[end,:];
z=q[end,:];
plot(x,y);
plot(x,z)
xlim([1,N]);
