% Extend the signal by simply fold and assemble
% Can be applied iteratively

function SuperTex = SuperTexture(Tex)

n = size(Tex,1);

SuperTex = [Tex;Tex(end:-1:1,:)];
SuperTex(n+1:end,1) = Tex(:,1) + Tex(end,1) + Tex(2,1) - Tex(1,1);

end

