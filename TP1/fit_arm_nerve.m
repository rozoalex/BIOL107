function [a,b,c,d] = fit_arm_nerve(filename)
% FIT_ARM_NERVE Fit Gaussian to arm nerve data
%
%   [A,B,C,D]=FIT_ARM_NERVE(FILENAME)
%
%  Loads in arm nerve data from FILENAME, and
%  examines if the responses across locations are 
%  significantly different via ANOVA analysis.
%  If so, then a gaussian fit is performed and 
%  A (offset) B (magnitude) C (peak location) and D
%  (tuning width parameter) are returned.  If the ANOVA
%  is not significant with alpha 0.05, then A,B,C,and D
%  are set to NaN.

  %Perform anova with rawdata and assigned groups for each location. Puts
  %the p-value into anova_p.
  data = load(filename,'-ascii');
  locations = data(1,:);
  rawdata = data(2:end,:);
  Num_reps = size(rawdata,1);
  G = repmat(1:length(locations),Num_reps,1); %creates groups for ANOVA
  rawdatac = rawdata(:); %put into one column
  GC = G(:); %put into one column
  [anova_p,~]=anova1(rawdatac,GC,'off');

  %If anova_p is less than 0.05, then perform a fit of the mean of the
  %rawdata at each location (each location has multiple response values)
  %using the gauss function a+b*exp(-((x-c).^2)/(2*d^2)). Then outputs the
  %parameters a, b, c, and d into their respective variables a, b, c, and
  %d. If anova_p is greater than or equal to 0.05, then the parameters a,
  %b, c, and d will output NaN (Not a Number).
  if anova_p<0.05
    x = locations.';
    y = mean(rawdata).';
    fo = fitoptions('Method','NonlinearLeastSquares',... 
        'Lower',[-20,-20,0,0],... 
        'Upper',[20,20,20,20],... 
        'Startpoint',[5 5 5 5]); %set bounds for [a,b,c,d]
    gauss = fittype('a+b*exp(-((x-c).^2)/(2*d^2))','options',fo);
    [parameters, ~] = fit(x, y, gauss);
    a = parameters.a;
    b = parameters.b;
    c = parameters.c;
    d = parameters.d;
  else
    a = NaN;
    b = NaN;
    c = NaN;
    d = NaN;
  end;
