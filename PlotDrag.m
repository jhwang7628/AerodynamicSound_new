A = load('forcesProcessed'); 

figure, plot(A(:,2:4)), title('pick the cut-off')


cutoff=3000; 

T = A(cutoff:end,1);
Force = A(cutoff:end,2:4);  
Force_coeff = Force./(0.5*1*10^2*0.25*0.01*0.02);
% Force_coeff = Force./(0.5*1*10^2*0.5*0.02);

figure, set(gcf,'outerposition', [2941,498,665,376],'paperpositionmode','auto')
plot(T,Force_coeff); 
% axis ([0, 1, 1, 3.5])
xlabel('$$T (s)$$','interpreter','latex')
ylabel('$$C_D = \frac{D}{0.5\rho v^2 A}$$','interpreter','LaTeX')

A_avg = sum(Force_coeff,1)./length(T)


[f,fftPv] = PlotFFTSignal(T,Force(:,2),1);
set(gcf,'outerposition', [2941,498,665,376],'paperpositionmode','auto')
set(gca,'xlim',[0,300])

