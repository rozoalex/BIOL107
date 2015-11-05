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

  data = load(filename,'-ascii');
  locations = data(1,:);
  rawdata = data(2:end,:);
  [anova_p, ~] = anova1(rawdata, [], 'off');
  if anova_p<0.05
    x = locations.';
    y = mean(rawdata).';
    fo = fitoptions('Method','NonlinearLeastSquares',... 
        'Lower',[-20,-20,0,0],... 
        'Upper',[20,20,20,20],... 
        'Startpoint',[5 5 5 5]); 
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