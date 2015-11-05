function refined_plot()
  %Run in mouse_data directory
  %Executes analyze_mouse_arm and removes NaNs.
  %Makes cumulative histograms of parameters
  %Performs ttests and prints results
  
  [a_ko,b_ko,c_ko,d_ko] = analyze_mouse_arm('knockout');
  [a_wt,b_wt,c_wt,d_wt] = analyze_mouse_arm('wildtype');

  %'a' parameter:
  % report numbers of any NaNs and remove them
  aNaN_ko = length(find(isnan(a_ko)));
  aNaN_wt = length(find(isnan(a_wt)));
  a_ko_good = a_ko(find(~isnan(a_ko)));
  a_wt_good = a_wt(find(~isnan(a_wt)));
  mean(a_ko_good);
  mean(a_wt_good);
  
  %'b' parameter:
  bNaN_ko = length(find(isnan(b_ko)));
  bNaN_wt = length(find(isnan(b_wt)));
  b_ko_good = b_ko(find(~isnan(b_ko)));
  b_wt_good = b_wt(find(~isnan(b_wt)));
  mean(b_ko_good);
  mean(b_wt_good);
  
  %'c' parameter:
  cNaN_ko = length(find(isnan(c_ko)));
  cNaN_wt = length(find(isnan(c_wt)));
  c_ko_good = c_ko(find(~isnan(c_ko)));
  c_wt_good = c_wt(find(~isnan(c_wt)));
  mean(c_ko_good);
  mean(c_wt_good);
  
  %'d' parameter:
  dNaN_ko = length(find(isnan(d_ko)));
  dNaN_wt = length(find(isnan(d_wt)));
  d_ko_good = d_ko(find(~isnan(d_ko)));
  d_wt_good = d_wt(find(~isnan(d_wt)));
  mean(d_ko_good);
  mean(d_wt_good);
  
  %cumhist of results:
  figure;
  %suptitle('Gaussian fit parameters of mouse arm response as a function of location');
  %'a' parameter:
  subplot(2,2,1)%subplot for a
  [X1,Y1] = cumhist(a_wt_good,[-10 5],1);
  [X2,Y2] = cumhist(a_ko_good,[-10 5],1);
  hold on
  plot(X1, Y1)
  plot(X2, Y2)
  xlabel('offset');
  ylabel('percentage')
  legend('wild-type','knockout','Location','southeast')
  %'b' parameter:
  subplot(2,2,2)%subplot for b
  [X1,Y1] = cumhist(b_wt_good,[-10 20],1);
  [X2,Y2] = cumhist(b_ko_good,[-10 20],1);
  hold on
  plot(X1, Y1)
  plot(X2, Y2)
  xlabel('magnitude');
  ylabel('percentage')
  legend('wild-type','knockout','Location','southeast')
  %'c' parameter:
  subplot(2,2,3)%subplot for c
  [X1,Y1] = cumhist(c_wt_good,[0 10],1);
  [X2,Y2] = cumhist(c_ko_good,[0 10],1);
  hold on
  plot(X1, Y1)
  plot(X2, Y2)
  xlabel('peak location');
  ylabel('percentage')
  legend('wild-type','knockout','Location','southeast')
  %'d' parameter:
  subplot(2,2,4)%subplot for d
  [X1,Y1] = cumhist(d_wt_good,[0 8],1);
  [X2,Y2] = cumhist(d_ko_good,[0 8],1);
  hold on
  plot(X1, Y1)
  plot(X2, Y2)
  xlabel('tuning width');
  ylabel('percentage')
  legend('wild-type','knockout','Location','southeast')
  
  [h,p] = ttest2(a_wt_good,a_ko_good);
  disp('a')
  disp(p)
  [h,p] = ttest2(b_wt_good,b_ko_good);
  disp('b')
  disp(p)
  [h,p] = ttest2(c_wt_good,c_ko_good);
  disp('c')
  disp(p)
  [h,p] = ttest2(d_wt_good,d_ko_good);
  disp('d')
  disp(p)
  
  
end