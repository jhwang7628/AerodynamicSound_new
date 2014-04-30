function Y = ReadFluent

  % data_folder = '/Users/jui-hsienwang/Documents/MATLAB/Aerodynamic_sound_Matlab/Fluent_data/Re120/v10_Dp01/'
  % data_folder = '/Volumes/StoreJet320/Aerodynamic_sound_test_cases/Re12000/tmp/'
  data_folder = '/Users/jui-hsienwang/Documents/MATLAB/Aerodynamic_sound_Matlab/Test/data/tmp/'
  
  FileLs = dir([data_folder, 'Pressure*']);

  A = dlmread([data_folder,FileLs(1).name],'',1,0);

  NumCell     = size(A,1); 
  NumDataCol  = 4;
  NumFile = length(FileLs);

  Y = zeros(NumCell, NumDataCol, NumFile);
  % Y = zeros(NumCell, NumDataCol, 60);
  kk = 1;
  
  for ii = 1:NumFile
     if ii ~= 1
        A = dlmread([data_folder,FileLs(ii).name],'',1,0); % Read without header
     end
     Y(:,1,kk) = A(:,1); % Cell number
     Y(:,2,kk) = A(:,4); % Pressure
     Y(:,3,kk) = A(:,9); % X-face-area
     Y(:,4,kk) = A(:,10); % Y-face-area

     kk = kk + 1;
     fprintf(['Loading file ', FileLs(ii).name, ' ... \n'])
  
  end
  
  fprintf(['Data from ', FileLs(1).name, ' to ', FileLs(NumFile).name, ' were successfully read to the system.\n']);

end

