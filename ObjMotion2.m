function [ObjPosition, ObjSpeed] = ObjMotion2(t_k, NumElem, flag)

ObjPosition = zeros(3,NumElem);
ObjSpeed    = zeros(1,NumElem);


if strcmpi(flag, 'standing_wind_random')
   
   k = 5; lambda = 15; 
   l = 2;

   ObjSpeed  = ones(1,NumElem).*RandWindSpeed(k, lambda);
   ObjSpeed  = ones(1,NumElem).*HarmWindSpeed(t_k);
   ObjSpeed  = ones(1,NumElem).*15;
   
   for ii = 1:NumElem
      ObjPosition(3,ii) = l/(NumElem-1)*(ii-1); 
      ObjPosition(1,ii) = 15; 
   end 

end


end
