function AnimObjMotion(T,O,X,NumElem,flag,skip)

if strcmpi(flag,'anim') == 1

   for ii = 1:skip:length(T)
      XPt = []; YPt = []; ZPt = [];
      for jj = 1:NumElem
         XPt = [XPt, X(ii,1,jj)];
         YPt = [YPt, X(ii,2,jj)];
         ZPt = [ZPt, X(ii,3,jj)];
      end
      if ii == 1
         figure, set(gcf,'outerposition', [800,0,800,600])
                 h1 = plot3(XPt, YPt, ZPt, 'ko-'); hold on,
                 h2 = plot3(O(1),O(2),O(3),'ro');
      else
         set(h1,'XData',XPt,'YData',YPt,'ZData',ZPt);
         axis equal
         axis([-15,15,-15,15,-5,5])
         refreshdata
         drawnow
         %set(gca,'xlim',[0-0.2,10+0.2],'ylim',[-0.2,1.7])
         grid on
                 title('Object motion')
                 xlabel('X'); ylabel('Y'); zlabel('Z')
         
      end
   end

elseif strcmpi(flag,'start_end') == 1
   
   figure, h1 = plot3(squeeze(X(  1,1,:)), squeeze(X(  1,2,:)), squeeze(X(  1,3,:)), 'bx-'); hold on,
           h2 = plot3(squeeze(X(end,1,:)), squeeze(X(end,2,:)), squeeze(X(end,3,:)), 'rx-'); hold on,
           h3 = plot3(O(1),O(2),O(3),'ro');
                 title('Object motion')
                 xlabel('X'); ylabel('Y'); zlabel('Z')
           
end

end



