x = [Bryce10deltaV,Bryce11deltaV,Bryce13deltaV,Bryce29deltaV];
y = [Bryce10deltaI,Bryce11deltaI,Bryce13deltaI,Bryce29deltaI];
x1 = [ Wen11deltaV,Wen15deltaV,Wen20deltaV,Wen4deltaV];
y1 = [ Wen11deltaI,Wen15deltaI,Wen20deltaI,Wen4deltaI];


x = x *100;
y = y *100;
x1 = x1 *100;
y1 = y1 *100;

p1 = scatter(x,y,'^','MarkerEdgeColor','black');
hold on;
p2 = scatter(x1,y1, 'MarkerEdgeColor','black');
hold off;

xlim([-30,30]);
ylim([-30,30]);
ytickformat('percentage');
xtickformat('percentage');
xlabel('Delta Valid','FontSize',16);
ylabel('Delta Invalid','FontSize',16);
xL = xlim;
yL = ylim;
hold off;
p3 = line([0 0], yL, 'color', 'k', 'LineStyle','--');  %x-axis
p4 = line(xL, [0 0],'color', 'k','LineStyle','--');  %y-axis
legend([p1 p2],{'Subject1','Subject2'}, 'FontSize', 16);
legend('boxoff');