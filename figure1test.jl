function izhfigure(a,b,c,d,V,u,tau,tspan,T1,cond,Ivalue,ax1,ax2,x,y,subplot_title)

    VV=[];  uu=[];
    for t=tspan
        if cond(t,T1)
            I=Ivalue;
        else
            I=0;
        end;
        V = V + tau*(0.04*V^2+5*V+140-u+I);
        u = u + tau*a*(b*V-u);
        if V > 30
            push!(VV,30);
            V = c;
            u = u + d;
        else
            push!(VV,V);
        end;
        push!(uu,u);
    end;
    ax=axes[ax1,ax2]
    ax[:plot](tspan,VV)
    ax[:plot](x,y)
    ax[:set_title](subplot_title)
    ax[:set_xlim]([0,tspan[end]])
    ax[:set_ylim]([-90,30])
    ax[:set_axis_off]();
end

function cond1(t,T1)
    return t>T1
end

using PyPlot

fig, axes = subplots(5,4,figsize=(10,10))

#(A) tonic spiking
endtime=100; T1=endtime/10;
izhfigure(0.02,0.2,-65,6,-70,0.2*(-70),0.25,0:0.25:endtime,T1,cond1,14,1,1,[0,T1,T1,endtime],-90+[0,0,10,10],"(A) tonic spiking")

# (B) phasic spiking
endtime=200; T1=20;
izhfigure(0.02,0.25,-65,6,-64,0.25*(-64),0.25,0:0.25:endtime,T1,cond1,0.5,1,2,[0,T1,T1,endtime],-90+[0,0,10,10],"(B) phasic spiking")

#(C) tonic bursting
endtime=220; T1=22;
izhfigure(0.02,0.2,-50,2,-70,0.2*(-70),0.25,0:0.25:endtime,T1,cond1,15,1,3,[0,T1,T1,endtime],-90+[0,0,10,10],"(B) phasic spiking")

#(D) phasic bursting
endtime=200; T1=20;
izhfigure(0.02,0.25,-55,0.05,-64,0.25*(-64),0.2,0:0.2:endtime,T1,cond1,0.6,1,4,[0,T1,T1,endtime],-90+[0,0,10,10],"(D) phasic bursting")

#(E) mixed mode
entime=160; T1=endtime/10;
izhfigure(0.02,0.2,-55,4,-70,0.2*(-70),0.25,0:0.25:endtime,T1,cond1,10,2,1,[0,T1,T1,endtime],-90+[0,0,10,10],"(E) mixed mode")

#(F) spike freq. adapt
endtime=85; T1=endtime/10;
izhfigure(0.01,0.2,-65,8,-70,0.2*(-70),0.25,0:0.25:endtime,T1,cond1,30,2,2,[0,T1,T1,endtime],-90+[0,0,10,10],"(F) spike freq. adapt")

#(G) Class 1 exc.
endtime=300; T1=30;
#izhfigure(0.02,-0.1,-55,6,-60,(-0.1)*(-60),0.25,0:0.25:endtime,T1,cond1,30,2,3,[0,T1,endtime,endtime],-90+[0,0,10,10],"(F) spike freq. adapt")
