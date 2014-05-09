[T,Pv_Re120            ,X,U,vl,O,S_k_mon] = main_v2([0,10,0],16000,Tex_Re120            );
[T,Pv_Re1200_Dobashi   ,X,U,vl,O,S_k_mon] = main_v2([0,10,0],16000,Tex_Re1200_Dobashi   );
[T,Pv_Re12000_ke90000  ,X,U,vl,O,S_k_mon] = main_v2([0,10,0],16000,Tex_Re12000_ke90000  );
[T,Pv_Re12000_kw90000  ,X,U,vl,O,S_k_mon] = main_v2([0,10,0],16000,Tex_Re12000_kw90000  );
[T,Pv_Re12000_dns45000 ,X,U,vl,O,S_k_mon] = main_v2([0,10,0],16000,Tex_Re12000_dns45000 );
[T,Pv_Re12000_dns180000,X,U,vl,O,S_k_mon] = main_v2([0,10,0],16000,Tex_Re12000_dns180000);

player_Re120             = audioplayer(Pv_Re120            ,16000);
player_Re1200_Dobashi    = audioplayer(Pv_Re1200_Dobashi   ,16000);
player_Re12000_ke90000   = audioplayer(Pv_Re12000_ke90000  ,16000);
player_Re12000_kw90000   = audioplayer(Pv_Re12000_kw90000  ,16000);
player_Re12000_dns45000  = audioplayer(Pv_Re12000_dns45000 ,16000);
player_Re12000_dns180000 = audioplayer(Pv_Re12000_dns180000,16000);
