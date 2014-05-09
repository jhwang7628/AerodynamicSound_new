% SPECIFY THE OBJECT MOTION (IN THE FUTURE CAN USE EXPERIMENTAL MOTION TRACKER)
   % discretize and describe the body motion in space, including position and velocity (speed and direction) for each element.
   % render the body motion animation? 
   % This object motion spans the length of physical time. 

function [X,U,vl] = ObjMotion(T,NumElem,flag)

global O

Anim = 0;


U = zeros(length(T),3,NumElem);
X = zeros(length(T),3,NumElem);
vl= zeros(length(T),NumElem); % Speed of the element


if strcmpi(flag, 'linear') % Linear motion
   
   % Constant velocity motion in x-direction with four partition
   for ii = 1:size(U,3)
      U(:,1,ii) = 15.*ones(length(T),1);
   end 

   dt = T(2)-T(1);
   for ii = 1:size(U,3)
      for jj = 2:length(T)
         X(jj,1,ii) = X(jj-1,1,ii) + (U(jj,1,ii) + U(jj-1,1,ii))*dt/2;
      end
   end
   
   X(:,2,1) = 0  .*ones(length(T),1,1);
   X(:,2,2) = 0.01.*ones(length(T),1,1);
   X(:,2,3) = 0.02.*ones(length(T),1,1);
   X(:,2,4) = 0.03.*ones(length(T),1,1);
      
   for ii = 1:length(T)
      for jj = 1:NumElem
         vl(ii,jj) = sqrt(U(ii,1,jj).^2 + U(ii,2,jj).^2 + U(ii,3,jj).^2);
      end
   end

elseif strcmpi(flag, 'rotate') % harmonic rotation

   vmax = 15; 
   for ii = 1:NumElem
      Ri(ii) = 10*(ii-1)/(NumElem-1);
   end
   % Ri = [0, 10/4, 20/4, 30/4, 10]; 
   om   = vmax/Ri(end);
   Tswing = pi^2/2*Ri(end)/vmax;
   % Tswing = 3;
   % Tswing = 0.1;
   % Tswing = 0.0197;
   % Tswing = 0.197;
   theta = pi/2   - pi/4.*cos(2*pi.*T./Tswing);
   omega = pi^2/2/Tswing.*sin(2*pi.*T./Tswing);

   for ii = 1:NumElem
      X(:,1,ii) = Ri(ii).*cos(theta);
      X(:,2,ii) = Ri(ii).*sin(theta);
      U(:,1,ii) = Ri(ii).*omega.*(-sin(theta));
      U(:,2,ii) = Ri(ii).*omega.*(+cos(theta));
   end

   for ii = 1:length(T)
      for jj = 1:NumElem
         vl(ii,jj) = sqrt(U(ii,1,jj).^2 + U(ii,2,jj).^2 + U(ii,3,jj).^2);
      end
   end

end


% Animation of the object
if Anim == 1;
   for ii = 1:length(T)
      XPt = []; YPt = []; ZPt = [];
      for jj = 1:NumElem
         XPt = [XPt, X(ii,1,jj)];
         YPt = [YPt, X(ii,2,jj)];
         ZPt = [ZPt, X(ii,3,jj)];
      end
      if ii == 1
         figure(1), h1 = plot3(XPt, YPt, ZPt, 'x-'); hold on,
                    h2 = plot3(O(1),O(2),O(3),'ro');
      else
         set(h1,'XData',XPt,'YData',YPt,'ZData',ZPt);
         refreshdata
         drawnow
         %set(gca,'xlim',[0-0.2,10+0.2],'ylim',[-0.2,1.7])
         grid on
      end
   end
end


end
   
