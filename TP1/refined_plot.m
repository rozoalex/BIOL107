%Generalized Steps (See below for more details)(Run in mouse_data directory)

%Executes analyze_mouse_arm, removes NaNs, finds mean of "good" parameter
%values for ko and wt.

%Performs ttests and inputs p-value.

%Makes cumulative histograms of parameters that displays t-test p-value.

%Plot all best fit curves for each "good" data set onto one graph for both
%ko and wt

%Uses the mean of the "good" parameters to plot the best fit curve for both
%ko and wt.

%Computes standard error and report mean of "good" parameters of a, b, c, and d of ko and wt with
%standard error.

%Report p-value of t-test between "good" parameters for ko and wt.


%Code

%Perform analyze_mouse_arm. Use help analyze_mouse_arm.m for more details. 
[a_ko,b_ko,c_ko,d_ko] = analyze_mouse_arm('knockout');
[a_wt,b_wt,c_wt,d_wt] = analyze_mouse_arm('wildtype');

%'a' parameter:
%Finds number of NaN for a_ko and a_wt and puts the number into aNaN_ko and
%aNaN_wt. Then finds the a_ko and a_wt that are not NaN and puts them into
%a_ko_good and a_wt_good. Then calculates the mean of a_ko_good and
%a_wt_good to mna_ko_good and mna_wt_good.
aNaN_ko = length(find(isnan(a_ko)));
aNaN_wt = length(find(isnan(a_wt)));
a_ko_good = a_ko(find(~isnan(a_ko)));
a_wt_good = a_wt(find(~isnan(a_wt)));
mna_ko_good = mean(a_ko_good);
mna_wt_good = mean(a_wt_good);
  
%'b' parameter:
%Finds number of NaN for b_ko and b_wt and puts the number into bNaN_ko and
%bNaN_wt. Then finds the b_ko and b_wt that are not NaN and puts them into
%b_ko_good and b_wt_good. Then calculates the mean of b_ko_good and
%b_wt_good to mnb_ko_good and mnb_wt_good.
bNaN_ko = length(find(isnan(b_ko)));
bNaN_wt = length(find(isnan(b_wt)));
b_ko_good = b_ko(find(~isnan(b_ko)));
b_wt_good = b_wt(find(~isnan(b_wt)));
mnb_ko_good = mean(b_ko_good);
mnb_wt_good = mean(b_wt_good);
  
%'c' parameter:
%Finds number of NaN for c_ko and c_wt and puts the number into cNaN_ko and
%cNaN_wt. Then finds the c_ko and c_wt that are not NaN and puts them into
%c_ko_good and c_wt_good. Then calculates the mean of c_ko_good and
%c_wt_good to mnc_ko_good and mnc_wt_good.
cNaN_ko = length(find(isnan(c_ko)));
cNaN_wt = length(find(isnan(c_wt)));
c_ko_good = c_ko(find(~isnan(c_ko)));
c_wt_good = c_wt(find(~isnan(c_wt)));
mnc_ko_good = mean(c_ko_good);
mnc_wt_good = mean(c_wt_good);
  
%'d' parameter:
%Finds numbers of NaN for d_ko and d_wt and puts the number into dNaN_ko and
%dNaN_wt. Then finds the d_ko and d_wt that are not NaN and puts them into
%d_ko_good and d_wt_good. Then calculates the mean of d_ko_good and
%d_wt_good to mnd_ko_good and mnd_wt_good.
dNaN_ko = length(find(isnan(d_ko)));
dNaN_wt = length(find(isnan(d_wt)));
d_ko_good = d_ko(find(~isnan(d_ko)));
d_wt_good = d_wt(find(~isnan(d_wt)));
mnd_ko_good = mean(d_ko_good);
mnd_wt_good = mean(d_wt_good);

%Performs a t-test for 'x'_wt_good and 'x'_ko_good ('x'=a,b,c,d) and puts
%p-value into p_'x'
[h,p_a] = ttest2(a_wt_good,a_ko_good);
[h,p_b] = ttest2(b_wt_good,b_ko_good);
[h,p_c] = ttest2(c_wt_good,c_ko_good);
[h,p_d] = ttest2(d_wt_good,d_ko_good);
  
%Plots a cumulative histogram of 'x'_wt_good and 'x'_ko_good ('x' =
%a,b,c,d). Then displays p_'x' value calculated in earlier t-test between
%good wt and ko.
figure;
suptitle({'Gaussian fit parameters of mouse arm response as a function of location','',''});
%'a' parameter:
subplot(2,2,1)%subplot for a
[X1,Y1] = cumhist(a_wt_good,[-10 5],1);
[X2,Y2] = cumhist(a_ko_good,[-10 5],1);
hold on
plot(X1, Y1)
plot(X2, Y2)
title(strcat('a of wild-type vs knockout, p_a= ',num2str(p_a)))
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
title(strcat('b of wild-type vs knockout, p_b= ',num2str(p_b)))
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
title(strcat('c of wild-type vs knockout, p_c= ',num2str(p_c)))
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
title(strcat('d of wild-type vs knockout, p_d= ',num2str(p_d)))
xlabel('tuning width');
ylabel('percentage')
legend('wild-type','knockout','Location','southeast')

%Uses all the "good" (without NaN) parameters a, b, c, and d and plots the function 
%a+b*exp(-((x-c).^2)/(2*d^2)) for each data set in mouse_data for wild type
%and knockout.
x = [0:0.5:15];
i=1;
figure;
hold on;
while i<15;
g_ko = a_ko_good(i)+b_ko_good(i)*exp(-((x-c_ko_good(i)).^2)/(2*d_ko_good(i)^2));
plot(x,g_ko,'-r');
i=i+1;
end
while i<26;
g_wt = a_wt_good(i)+b_wt_good(i)*exp(-((x-c_wt_good(i)).^2)/(2*d_wt_good(i)^2));
plot(x,g_wt,'-b');
i=i+1;
end
title('Plot of Gauss Fit Curves for All Data');
xlabel('Locations (mm)'); 
ylabel('Mean response (spikes/sec)');

%Uses the mean of the "good" parameters a, b, c, and d and plots the function 
%a+b*exp(-((x-c).^2)/(2*d^2))for wild type and knockout.
x = 0:15;
fitko = (mna_ko_good+mnb_ko_good*exp(-((x-mnc_ko_good).^2)/(2*(mnd_ko_good)^2)));
figure;
plot(x,fitko);
hold on
fitwt = (mna_wt_good+mnb_wt_good*exp(-((x-mnc_wt_good).^2)/(2*(mnd_wt_good)^2)));
plot(x,fitwt);
legend ('ko','wt');
xlabel('Locations (mm)'); 
ylabel('Mean response (spikes/sec)');
title('Mean fit parameter curve of wild type and knockout of mouse arm reponse as a function of location');

%Computes standard error and report mean of "good" parameters of a, b, c, and d of ko and wt with
%standard error.

disp('Mean ko offset (a)')
stdparameter = std(a_ko_good);
Num = size(a_ko_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mna_ko_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')
disp('Mean wt offset (a)')
stdparameter = std(a_wt_good);
Num = size(a_wt_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mna_wt_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')
disp('Mean ko magnitude (b)')
stdparameter = std(b_ko_good);
Num = size(b_ko_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mnb_ko_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')
disp('Mean wt magnitude (b)')
stdparameter = std(b_wt_good);
Num = size(b_wt_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mnb_wt_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')
disp('Mean ko peak location (c)')
stdparameter = std(c_ko_good);
Num = size(c_ko_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mnc_ko_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')
disp('Mean wt peak location (c)')
stdparameter = std(c_wt_good);
Num = size(c_wt_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mnc_wt_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')
disp('Mean ko tuning width (d)')
stdparameter = std(d_ko_good);
Num = size(d_ko_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mnd_ko_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')
disp('Mean wt tuning width (d)')
stdparameter = std(d_wt_good);
Num = size(d_wt_good(:),1);
std_e = stdparameter/sqrt(Num);
dispstd_e = [num2str(mnd_wt_good),' plus or minus ',num2str(std_e)];
disp(dispstd_e)
disp(' ')

%Report t-test p-values between wt and ko of "good" a, b, c,and d parameters.
disp('T-test p_a')
disp(p_a)
disp('T-test p_b')
disp(p_b)
disp('T-test p_c')
disp(p_c)
disp('T-test p_d')
disp(p_d)
