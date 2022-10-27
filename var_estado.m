function [b_th,b_m,a_m,u_lon_m,u_lat_m,vel,vel_lon,acel,acel_lon,acel_lat]=var_estado(x,theta,n,F_n,mu,W_f,v_ini)
mtheta=(theta(2:end)+theta(1:end-1))./2;

%%%%%%%%%%%%



% 
% s_thetax=spline(theta,mx,theta,0);
% s_thetay=spline(theta,my,theta,0);
% s_spline=[s_thetax;s_thetay]
Sxx=[3.500000000000000  
   3.292258882683241  
   3.084517765366481  
   2.876776648049722  
   2.669035530732963  
   2.461294413416203  
   2.253553296099444  
   2.045812178782685  
   1.838071061465925 
   1.630329944149166  
   1.422588826832407  
   1.214847709515648  
   1.007106592198888 
   0.799365474882129 
   0.591624357565370 
   0.383883240248610 
   0.176142122931851  
  -0.031593736066836 
  -0.237061600156216  
  -0.432335486187040 
  -0.609018345846571  
  -0.759512570776878  
  -0.877346700286442  
  -0.957453703148032 
  -0.996388866979004 
  -0.992477925658072   
  -0.945889055093893 
  -0.858625641427417   
  -0.734440132645344   
  -0.578672678104976   
  -0.398021494694982   
  -0.200254834206120   
   0.006123100546506   
   0.213864217863264   
   0.421605335180023  
   0.629346452496783   
   0.837087569813542   
   1.044828687130302   
   1.252569804447060   
   1.460310921763820  
   1.667262148686973   
   1.867010451871276   
   2.050976795888971   
   2.211250372438786  
   2.340939195127150   
   2.434466464455310  
   2.487810377943322   
   2.501322926777481   
   2.533400732696720   
   2.607043649607410  
   2.719084929800683   
   2.864706642615520   
   3.037646852148745   
   3.230468889195969   
   3.434881138356093   
   3.642576145242177   
   3.850317262558935   
   4.058058379875696   
   4.265799497192455   
   4.473540614509213   
   4.681281731825974  
   4.889022849142733  
   5.096726219765991   
   5.303329999481320   
   5.506664064993327   
   5.704536597876001   
   5.894814651726681   
   6.075447144040108   
   6.244486965639117   
   6.400111969335651   
   6.540644611576977  
   6.664570035352078   
   6.770552399435348  
   6.857449277948247   
   6.924323975020323   
   6.970455621804997  
   6.995346947010366   
   6.998729637183417   
   6.980567228967003   
   6.941055502152815  
   6.880620369293462   
   6.799913284622378   
   6.699804221770624  
   6.581372295976545  
   6.445894131875217  
   6.294830102255879  
   6.129808586125232  
   5.952608415765175  
   5.765139701995109  
   5.569423244330872  
   5.367568747986406  
   5.161752082525651  
   4.954187821217316  
   4.746446703900555  
   4.538705586583797  
   4.330964469267038  
   4.123223351950278  
   3.915482234633520  
   3.707741117316758  
   3.500000000000000]';

 Syy=[-1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -0.999500793317013
    -0.971494620536508
    -0.901712829776429
    -0.793156134958500
    -0.650492624732901
    -0.479857028182867
    -0.288586912953655
    -0.084907159652748
    0.122423719439701
    0.324490208563497
    0.512603168038744
    0.678673479340315
    0.815559888429301
    0.917376089595086
    0.979743844776317
    1.000000000000000
    1.000000000000000
    1.000000000000000
    1.000000000000000
    1.000000000000000
    1.000000000000000
    1.000000000000000
    1.000000000000000
    1.014087542620230
    1.069783182146634
    1.165479436807023
    1.297061234739691
    1.458870375881249
    1.643948842427956
    1.844338003265180
    2.051420846158964
    2.256292521250156
    2.450143261966172
    2.624637217219400
    2.772270904581518
    2.886695870449409
    2.962991682367374
    2.997877514456660
    3.000000000000000
    3.000000000000000
    3.000000000000000
    3.000000000000000
    3.000000000000000
    3.000000000000000
    3.000000000000000
    2.997659640281542
    2.976863908167343
    2.934758777017031
    2.871798114715716
    2.788660599178966
    2.686242402614753
    2.565647531328281
    2.428175925200760
    2.275309445122565
    2.108695899427784
    1.930131281515535
    1.741540410125798
    1.544956180955847
    1.342497653272373
    1.136347207732360
    0.928727021637608
    0.721875115205481
    0.518021227062557
    0.319362779008875
    0.128041189137995
    -0.053881211356746
    -0.224443408867012
    -0.381806845911835
    -0.524275239676886
    -0.650312866918787
    -0.758561118134188
    -0.847853142549709
    -0.917226426068581
    -0.965933166591302
    -0.993448334870662
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000
    -1.000000000000000]';


dSxdthm=[-20.566370614359176 
-20.566370614359176 
-20.566370614359176 
-20.566370614359176 
-20.566370614359176 
-20.566370614359133 
-20.566370614359176 
-20.566370614359176 
-20.566370614359176 
-20.566370614359155
-20.566370614359155 
-20.566370614359197 
-20.566370614359187 
-20.566370614359133 
-20.566370614359187 
-20.566370614359197 
-20.565850040870028 
-20.341318544848527 
-19.332114717051592 
-17.491603106293638 
-14.898928268100310 
-11.665578821446831 
-7.930593283297454 
-3.854581219266201 
0.387183190772241 
4.612298185853681 
8.639077952981161 
12.294365369425183 
15.420977999496431 
17.884467157589409 
19.578899388397403 
20.431415540509906 
20.566370614359077 
20.566370614359187 
20.566370614359187 
20.566370614359197 
20.566370614359176 
20.566370614359087 
20.566370614359176 
20.488171465392217 
19.775082015245911 
18.212668057751809 
15.867084078431738 
12.839193446148025 
9.259199663487852 
5.281047435313170 
1.337742334581782 
3.175702786004576 
7.290648774158356 
11.092086739134034 
14.416549568668877 
17.121080743789193 
19.089381667675219 
20.236812666852288 
20.561805681722305 
20.566370614359087 
20.566370614359307 
20.566370614359087 
20.566370614359087 
20.566370614359354 
20.566370614359087 
20.562633691702523 
20.453774191817576
20.130072485688718 
19.589380755384749 
18.837527331217284 
17.882616739029320 
16.734942338301888 
15.406875365956807 
13.912731581891295 
12.268616953735005
10.492254044243751 
8.602790972776930 
6.620595010135605 
4.567033031682700 
2.464241195331494 
0.334886327132086 
-1.798078413424965 
-3.911660954604657 
-5.983078153075933 
-7.990001382437294 
-9.910797222323627 
-11.724760653613810 
-13.412338246031565 
-14.955338932314369 
-16.337130096934136 
-17.542816865645616 
-18.559402663236547 
-19.375929308759392 
-19.983595138102128 
-20.375849880614783 
-20.548861869525126 
-20.566370614359354 
-20.566370614359087 
-20.566370614359087 
-20.566370614359265 
-20.566370614359087 
-20.566370614359354 
-20.566370614359087 ]';

dSydthm=[0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0.049421461615678
 2.772611105269983
 6.908397285247827
 10.747112786975043
 14.123687512334287
 16.892924058453339
 18.935741407692042
 20.164295576789790
 20.525757030152366
 20.004582423255794
 18.623182988049475
 16.440960818855530
 13.551754499809654
 10.079803915412731
 6.174407762941797
 2.005359367144646
 0
 0
 0
 0
 0
 0
 0
1.394666719402774
 5.513868313113984
 9.473929211378511
 13.026597995334141
 16.019104973014226
 18.322768188124048
 19.838526922885098
 20.501201446484689
 20.282295834027970
 19.191223330885620
 17.274901570069535
 14.615735048849661
 11.328071620921216
 7.553285379878520
 3.453697376839355
 0.210126068790632
 0
 0
 0
 0
 0
 0
 -0.231695612127334
 -2.058777479305673
 -4.168407983880910
 -6.233105567830187
 -8.230614038138247
 -10.139401459857089
 -11.938892257360722
 -13.609689006624640
 -15.133781527741208
 -16.494741023783387
 -17.677897173312658
 -18.670496267583903
 -19.461838687825225
 -20.043394240663840
 -20.408894108461279
 -20.554398423380476
 -20.478338736780628
 -20.181534926149379
 -19.667186357314609
 -18.940837397217042
 -18.010317648979385
 -16.885657553516335
 -15.578980267437467
 -14.104370982740052
 -12.477725096948202
 -10.716576870324658
 -8.839910417136652
 -6.867955068368290
 -4.821967311749407
 -2.724001659656614
 -0.648614847804464
 0
 0
 0
 0
 0
 0
 0]';


d2Sxdth=1.0e+02 *[-0.000000000000044 
0 
0 
0 
0.000000000000022 
0 
-0.000000000000022 
0 
0.000000000000011 
0.000000000000011 
-0.000000000000022 
-0.000000000000016 
0.000000000000033 
0 
-0.000000000000033 
0.000257683877133 
0.111400774407783 
0.610698985290126 
1.410609142084668 
2.194427292230885 
2.883882020999168 
3.449325817477414 
3.866443813079417 
4.117299354664499 
4.191105305534347 
4.084687907293415 
3.802623255867894 
3.357040523025058 
2.767100385141291 
2.058171087505980 
1.260739449545647 
0.488798256851030 
0.066802761555394 
0.000000000000054 
0.000000000000005 
0 
-0.000000000000054 
0 
-0.038708578738602 
-0.391687856561066 
-1.126374186782000 
-1.934458978723015 
-2.659869932743874 
-3.270902785397224 
-3.741282275363254 
-3.921121377808504
-1.042145601407754 
2.946688687590404 
3.918610056799082 
3.527320893282708 
2.984352032304304 
2.313051889008139 
1.542287301916231
0.728849886953307 
0.163131184015867 
0.002259641655339 
0 
-0.000000000000087 
0.000000000000131 
0 
-0.001849776715130 
-0.055735229158049 
-0.214117796976833 
-0.427874751034249 
-0.639809851463361 
-0.844848188095938 
-1.040779571493120 
-1.225491979670893 
-1.396994324423244 
-1.553437914049792 
-1.693136381135534 
-1.814583860574247 
-1.916471221883532 
-1.997700180841644 
-2.057395138328035 
-2.094912618752554 
-2.109848206334447 
-2.102040904459688 
-2.071574871127229 
-2.018778511777155 
-1.944220939277608 
-1.848705839232376 
-1.733262806735430 
-1.599136247956776 
-1.447771966196773 
-1.280801576998968 
-1.100024920319692 
-0.907390659341318 
-0.704975275058463 
-0.494960683068419 
-0.279807032054384 
-0.094307763203562 
-0.008666828692812 
0.000000000000131 
-0.000000000000087 
0 
-0.000000000000044 
0 
0.000000000000087 ]';

d2Sydth=1.0e+02 *[ 0
 0
 0
0 
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0
 0.024463623499760
 1.372442497108642
 3.395193032697914
3.947378332444005
 3.571568662407797
 3.042176579381756
 2.381966678202089
 1.619328901576544
 0.787057733117860
 -0.079058010999327
 -0.941774150840929
 -1.763992694178129
 -2.510357101678715
 -3.148772667204186
 -3.651786634749584
 -3.996850051392696
 -3.056331842656189
 -0.992652886736600
 0
 0
 0
 0
 0
 0.690360026104373
 2.729364814991422
 3.999234933527989
 3.718801192698978
 3.239862002009680
 2.621604245431003
 1.890613865186082
 1.078324462888507
 0.219665611015732
 -0.648439167221539
 -1.488660160659426
 -2.264866699607800
 -2.943680824828418
 -3.495912586140714
 -3.897815250820521
 -3.634863858988505
 -1.709580201535481
 -0.104012404051363
 0
 0
 0
 0
 -0.114689328003030
-1.019094852256308
 -1.948672624018020
 -2.066292403819634
 -2.010791996857382
-1.933616466553316
 -1.835597718515125
-1.717792335649938
-1.581470188838340
 -1.428100748493580
-1.259337244557868
 -1.076998845681255
 -0.883051049683720
 -0.679584496674570
 -0.468792433214847
 -0.252947070444734
 -0.034375091018078
 0.184567431129393
 0.401520427835680
 0.614145276821508
 0.820150010625935
 1.017314022631850
 1.203512003863250
 1.376736852534260
 1.535121309392186
 1.676958085645620
 1.800718266506717
 1.905067791968402
 1.988881837166687
 2.051256937312280
 2.065809469652746
 1.348380821530024
 0.321064349663210
 0
 0
 0
 0
 0
 0]';




dSdt_m=[dSxdthm;dSydthm];
d2Sdt_m=[d2Sxdth;d2Sydth];

%%%%%%%%%%%




l=n-1;

b_th=zeros(n,1);
a_m=zeros(l,1);
u_lon_m=zeros(l,1);
u_lat_m=zeros(1,l);
for i=1:n
    b_th(i)=x(i);
end

for i=1:l
a_m(i)=x(l+1+i);
u_lon_m(i)=x(2*l+1+i);
u_lat_m(i)=x(3*l+1+i);
end

vel=zeros(2,n-1);
vel_lon=zeros(1,n-1);


vel_lon(1)=v_ini;
b_m=(b_th(2:end)+b_th(1:end-1))./2;
acel=zeros(2,n-1);
acel_lon=zeros(1,n-1);
acel_lat=zeros(1,n-1);

for i=1:n-1
   acel(:,i)=d2Sdt_m(:,i)*b_m(i)+dSdt_m(:,i)*a_m(i);
   acel_lon(i)=dot(d2Sdt_m(:,i),dSdt_m(:,i))*(b_m(i)/norm(dSdt_m(:,i),2))+norm(dSdt_m(:,i),2)*a_m(i);
   acel_lat(i)=dot(d2Sdt_m(:,i),[dSdt_m(2,i),-dSdt_m(1,i)])*(b_m(i)/norm(dSdt_m(:,i),2));
   vel(:,i)=dSdt_m(:,i)*sqrt(b_m(i));
   vel_lon(i)=norm(dSdt_m(:,i),2)*sqrt(b_m(i));
end
vel_lon(1)=v_ini;
figure(6)
plot(Sxx(1:17),Syy(1:17),'g','LineWidth',2.5)
hold on
plot(Sxx(17:33),Syy(17:33),'r','LineWidth',2.5)
plot(Sxx(33:40),Syy(33:40),'g','LineWidth',2.5)
plot(Sxx(40:48),Syy(40:48),'k','LineWidth',2.5)
plot(Sxx(48:56),Syy(48:56),'r','LineWidth',2.5)
plot(Sxx(56:62),Syy(56:62),'g','LineWidth',2.5)
plot(Sxx(62:93),Syy(62:93),'c','LineWidth',2.5)
plot(Sxx(93:end),Syy(93:end),'g','LineWidth',2.5)


axis 'equal'



figure(200)
clf
hold on

subplot(4,1,1)
plot(theta,b_th,'LineWidth',2.5)
title('$b$','Interpreter','latex','fontsize',15,'FontWeight','bold')

subplot(4,1,2)
plot(mtheta,a_m,'LineWidth',2.5)
title('$a$','Interpreter','latex','fontsize',15,'FontWeight','bold')

subplot(4,1,3)
plot(mtheta,u_lon_m,'LineWidth',2.5)
title('$u_{long}$','Interpreter','latex','fontsize',15,'FontWeight','bold')
subplot(4,1,4)
plot(mtheta,u_lat_m,'LineWidth',2.5)
title('$u_{lat}$','Interpreter','latex','fontsize',15,'FontWeight','bold')

figure(201)
clf
hold on
subplot(2,1,1)
plot(mtheta,vel(1,:),mtheta,vel(2,:),'LineWidth',2.5)
title('$\vec{v}$','Interpreter','latex','fontsize',15,'FontWeight','bold')
subplot(2,1,2)
plot(mtheta,acel(1,:),mtheta,acel(2,:),'LineWidth',2.5)
title('$\vec{a}$','Interpreter','latex','fontsize',15,'FontWeight','bold')



figure(202)
clf
hold on
subplot(2,1,1)
plot(mtheta(1:17),vel_lon(1:17),'Color','g','LineWidth',2.5)
hold on
plot(mtheta(17:33),vel_lon(17:33),'Color','r','LineWidth',2.5)
plot(mtheta(33:40),vel_lon(33:40),'Color','g','LineWidth',2.5)
plot(mtheta(40:48),vel_lon(40:48),'Color','k','LineWidth',2.5)
plot(mtheta(48:56),vel_lon(48:56),'Color','r','LineWidth',2.5)
plot(mtheta(56:62),vel_lon(56:62),'Color','g','LineWidth',2.5)
plot(mtheta(62:93),vel_lon(62:93),'Color','c','LineWidth',2.5)
plot(mtheta(93:end),vel_lon(93:end),'Color','g','LineWidth',2.5)
%line([mtheta(17),mtheta(17)],[0,vel_lon(17)],'Color','r','LineStyle','--','LineWidth',1.5)
title('$\vec{v}_{ T}$','Interpreter','latex','fontsize',15,'FontWeight','bold')

subplot(2,1,2)
plot(mtheta(1:17),acel_lon(1:17),'Color','g','LineWidth',2.5)
hold on
plot(mtheta(17:33),acel_lon(17:33),'Color','r','LineWidth',2.5)
plot(mtheta(33:40),acel_lon(33:40),'Color','g','LineWidth',2.5)
plot(mtheta(40:48),acel_lon(40:48),'Color','k','LineWidth',2.5)
plot(mtheta(48:56),acel_lon(48:56),'Color','r','LineWidth',2.5)
plot(mtheta(56:62),acel_lon(56:62),'Color','g','LineWidth',2.5)
plot(mtheta(62:93),acel_lon(62:93),'Color','c','LineWidth',2.5)
plot(mtheta(93:end),acel_lon(93:end),'Color','g','LineWidth',2.5)
plot(mtheta,acel_lat,'k--','LineWidth',1.5)
title('$\vec{a}_{ T}$ y $\vec{a}_{N}$ ','Interpreter','latex','fontsize',15,'FontWeight','bold')
hold off

figure(501)
clf
hold on
subplot(2,1,1)
plot(mtheta(1:17),u_lon_m(1:17),'Color','g','LineWidth',2.5)
hold on
plot(mtheta(17:33),u_lon_m(17:33),'Color','r','LineWidth',2.5)
plot(mtheta(33:40),u_lon_m(33:40),'Color','g','LineWidth',2.5)
plot(mtheta(40:48),u_lon_m(40:48),'Color','k','LineWidth',2.5)
plot(mtheta(48:56),u_lon_m(48:56),'Color','r','LineWidth',2.5)
plot(mtheta(56:62),u_lon_m(56:62),'Color','g','LineWidth',2.5)
plot(mtheta(62:93),u_lon_m(62:93),'Color','c','LineWidth',2.5)
plot(mtheta(93:end),u_lon_m(93:end),'Color','g','LineWidth',2.5)
%line([mtheta(17),mtheta(17)],[0,vel_lon(17)],'Color','r','LineStyle','--','LineWidth',1.5)
title('$u_{long}$','Interpreter','latex','fontsize',15,'FontWeight','bold')

subplot(2,1,2)
plot(mtheta(1:17),u_lat_m(1:17),'Color','g','LineWidth',2.5)
hold on
plot(mtheta(17:33),u_lat_m(17:33),'Color','r','LineWidth',2.5)
plot(mtheta(33:40),u_lat_m(33:40),'Color','g','LineWidth',2.5)
plot(mtheta(40:48),u_lat_m(40:48),'Color','k','LineWidth',2.5)
plot(mtheta(48:56),u_lat_m(48:56),'Color','r','LineWidth',2.5)
plot(mtheta(56:62),u_lat_m(56:62),'Color','g','LineWidth',2.5)
plot(mtheta(62:93),u_lat_m(62:93),'Color','c','LineWidth',2.5)
plot(mtheta(93:end),u_lat_m(93:end),'Color','g','LineWidth',2.5)
title('${u}_{lat}$','Interpreter','latex','fontsize',15,'FontWeight','bold')
hold off
% figure(300)
% clf; 
% subplot(3,1,1)
% hold on;
% plot(mtheta,s_th_stag(1,:))
% plot(mtheta,s_th_stag(2,:))
% subplot(3,1,2)
% hold on;
% plot(mtheta,dSdt_m(1,:))
% plot(mtheta,dSdt_m(2,:))
% subplot(3,1,3)
% hold on;
% plot(mtheta,d2Sdt_m(1,:))
% plot(mtheta,d2Sdt_m(2,:))





figure(2)
 clf
 
    scatter(u_lon_m(1:17),u_lat_m(1:17),52,'g','LineWidth',1.5)
    hold on
    scatter(u_lon_m(18:33),u_lat_m(18:33),52,'r','LineWidth',1.5)
    scatter(u_lon_m(34:40),u_lat_m(34:40),52,'g','LineWidth',1.5)
    scatter(u_lon_m(41:48),u_lat_m(41:48),52,'k','LineWidth',1.5)
    scatter(u_lon_m(49:56),u_lat_m(49:56),52,'r','LineWidth',1.5)
    scatter(u_lon_m(57:62),u_lat_m(57:62),52,'g','LineWidth',1.5)
    scatter(u_lon_m(63:93),u_lat_m(63:93),52,'c','LineWidth',1.5)
    scatter(u_lon_m(94:end),u_lat_m(94:end),52,'g','LineWidth',1.5)
    %scatter(u_lon_m(94:end),u_lat_m(94:end),100*[1:(n-1)]/(n-1)+10,'o')
  tt = linspace(0,2*pi,100);
 xx = mu*F_n*cos(tt);
 yy = mu*F_n*sin(tt);
 plot(xx,yy,'r-','LineWidth',1.5)
 plot([mu*W_f*F_n, mu*W_f*F_n],[-mu*F_n,mu*F_n],'k--','LineWidth',1.5)
 xlabel('$u_{long}$','Interpreter','latex','fontsize',15)
 ylabel('$u_{lat}$','Interpreter','latex','fontsize',15)
 axis 'equal'
 %Y(2*N+2:3*N+1)
 
 figure(66)
 plot(Sxx,Syy,'LineWidth',2.5)
axis 'equal'

 