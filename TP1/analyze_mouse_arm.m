function [a,b,c,d] = analyze_mouse_arm(directoryName)

  subdirs = dir(directoryName);
  fileCount = length(subdirs);
  % initialize arrays to store parameters
  a = NaN(fileCount, 1);
  b = NaN(fileCount, 1);
  c = NaN(fileCount, 1);
  d = NaN(fileCount, 1);
  for i = 1:fileCount
    % load data from file
    if subdirs(i).isdir && ~strcmp(subdirs(i).name, '.') && ~strcmp(subdirs(i).name, '..')
      filename = [directoryName filesep subdirs(i).name filesep 'mouse_arm_data.txt'];
      [a_, b_, c_, d_] = fit_arm_nerve(filename);
        a(i) = a_;
        b(i) = b_;
        c(i) = c_;
        d(i) = d_;
    end
  end
end