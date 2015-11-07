function [a,b,c,d] = analyze_mouse_arm(folder)
% analyze_mouse_arm - Analyze folder of data
%  [a,b,c,d] = analyze_mouse_arm(foldername)
%
%  Goes through all subdirectories of foldername and looks for the file
%  'mouse_arm_data.txt'.
%
%  If it finds one, then it performs a fit
%  using fit_arm_nerve.m.  The A, B, C, D
%  of that function are returned.
%
%

subdirs = dir(folder);
a = []; b = []; c = []; d = [];

for i=1:length(subdirs), %repeat until through looking through all subdirectories
    %Once in subdirectory, will look for anything named
    %'mouse_arm_data.txt'
    if subdirs(i).isdir&~strcmp(subdirs(i).name,'.')&~strcmp(subdirs(i).name,'..'),
        filename = [folder filesep subdirs(i).name filesep 'mouse_arm_data.txt'];
        %If 'mouse_arm_data.txt' is found, it will perform fit_arm_nerve.m
        %and output best fit parameters to a, b, c, and d.
        if exist(filename),
            disp(['Analyzing file ' filename '.']);
            [a_,b_,c_,d_] = fit_arm_nerve(filename);
            a(end+1) = a_;
            b(end+1) = b_;
            c(end+1) = c_;
            d(end+1) = d_;
            %then repeat for other subdirectories
        end;
    end;
end;
