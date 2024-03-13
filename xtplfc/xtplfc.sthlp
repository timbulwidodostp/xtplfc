{smcl}
{* *! version 1.0 21Aug2018}{...}
{cmd:help xtplfc} 
{hline}

{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{hi:xtplfc} {hline 2}}Partially Linear Functional-Coefficient Panel Data Models{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 17 2}
{cmd:xtplcf} {varlist} {cmd:,} {cmdab:z:vars(}{varlist}{cmd:)} {cmdab:u:vars(}{varlist}{cmd:)} {cmdab:gen:erate(}{it:prefix}{cmd:)} 
[{it:options}]


{synoptset 28 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent :* {cmdab:z:vars(}{it:{help varlist:varlist}}{cmd:)}}specify variables that have functional coefficients.{p_end}
{p2coldent :* {cmdab:u:vars(}{it:{help varlist:varlist}}{cmd:)}}specify variables that enter into the functions.{p_end}
{p2coldent :* {cmdab:gen:erate(}{it:prefix}{cmd:)}}specify a prefix for the names to store fitted values of functional coefficients. {p_end}
{synopt :{opt te}}specify including time fixed effects.{p_end}
{synopt :{cmd: power(numlist)}}specify the power (or degree) of the splines for the functions.{p_end}
{synopt:{cmdab:nk:nots(numlist)}}specify the number of knots used for the spline interpolation. {p_end}
{synopt:{cmdab:quan:tile}}specify creating knots based on empirical quantiles. {p_end}
{synopt:{cmdab:maxnk:nots(numlist)}}specify the maximun number of knots used for performing LSCV. {p_end}
{synopt:{cmdab:minnk:nots(numlist)}}specify the minimun number of knots used for performing LSCV. {p_end}
{synopt :{cmd: grid(string)}}specify the name for storing the grid points of the variable specified by {cmd:uvar(varlist)}.{p_end}
{synopt :{opt pctile(#)}}specify the domain of the generating grid points. The default is {cmd:pctile(0)}. {p_end}
{synopt :{opt brep(#)}}specify the number of bootstrap replications. The default is {cmd:brep(200)}.{p_end}
{synopt :{opt wild}}specify using the wild bootstrap. By default, residual bootstrap with cluster(panelvar) is performed.{p_end}
{synopt :{opt predict(prspec)}}store predicted values of
the conditional mean and fixed effects using variable names specified in {it:prspec}{p_end}
{synopt :{opt nodots}}suppress iteration dots.{p_end}
{synopt :{opt level(#)}}set confidence level; default is {cmd:level(95)}.{p_end}
{synopt :{opt fast}}speed up using mata functions.{p_end}
{synopt :{opt tenfoldcv}}specify using ten-fold CV instead of LSCV.{p_end}

{synoptline}
{p2colreset}{...}
{p 4 6 2}* zvars(),uvars(), and generate() are required.{p_end}
{p 4 6 2}Note: Unbalanced panel data must be rectangularized in advance; use {help tsfill:tsfill},full.{p_end}



{title:Description}

{pstd}{opt xtplfc} estimates An, Cheng and Li's (2016) partially linear functional-coefficient panel data models. 

{pstd}The model can be expressed as:

{space 14}          Y_it=X_it'*\beta+Z_it'*G(U_it)+a_i+e_it

{pstd}where subscripts i and t present individual and time period, respectively; X_it 
and Z_it are vectors of covariates, respectively; G(U_it) is a vector of functional coefficients, 
and U_it is a vector of continuous variables (Specifically, Z_it'*G(U_it)=\sum(Z_jit*G_j(U_jit))); 
a_i represents the fixed effects; e_it is the idiosyncratic error.

{pstd}We approximate the functional coefficients by a linear combination of B-spline base functions. The fixed effects is removed by the first time difference. Then the transformed model is estimated through the least square technique. 


{title:Options}

{phang}{cmd:zvars(}{it:{help varlist:varlist}}{cmd:)} specifies the variables that have functional coefficients. {cmd:zvars()}is required.

{phang}{cmd:uvars(}{it:{help varlist:varlist}}{cmd:)} specifies (continuous) variables that enter into 
the functional coefficients interacted with variables specified by zvars() in order. {cmd:uvars()}is required.

{phang}{cmd:generate(}{it:prefix}{cmd:)} specifies a prefix for the variable names to store fitted values of functional coefficients. {cmd:generate()}is required.

{phang}{opt te} specifies including time fixed effects.

{phang}{opt power(numlist)} (nonnegative integers) specifies the power (or degree) of the splines in order specified by uvars(). If absent, 3 is assumed for all the functions.

{phang}{opt nknots(numlist)} specifies the number of knots used for the spline interpolation in order specified by uvars(). 
If absent, 2 is assumed for all the functions.

{phang}{opt quantile} specifies creating knots based on empirical quantiles. By default, the knots are generated by the rule of equal space.

{phang}{opt maxnknots(numlist)} specifies the maximun number of knots used for performing LSCV. If present, LSCV is employed to determine the optimal number of knots. In our practice, we perform the 
Leave-One-Out CV across the panelvar. That is to say, we leave one individual (with all observations during the sample period) out each time. 

{phang}{opt minnknots(numlist)} specifies the minimun number of knots used for performing LSCV. If absent, 2 is assumed.

{phang}{opt grid(string)} specifies the name for storing the grid points of the variable specified by {cmd:uvar(varname)}. If present, the functional coefficients are estimated over the grid points. By default, 
they are estimated over the observations.

{phang}{opt pctile(#)} specifies the domain of the generating grid points. It can be only used when {cmd: grid(string)} is specified. The default is pctile(0).

{phang}{opt brep(#)} specifies the number of bootstrap replications. The default is brep(200). We recommend that you select the number of replications.{p_end}

{phang}{opt wild} specifies using the wild bootstrap. By default, residual bootstrap with cluster(panelvar) is performed.

{phang}{opt predict(prspec)} stores predicted values of
the dependent variable and fixed effects using variable names specified in {it:prspec}. {it:prspec} is the following:

{phang2}
{cmd:predict(}{varlist}|{it:stub}{cmd:*} [{cmd:, replace noai}]{cmd:)}

{pmore}
The option takes a variable list or a {it:stub}.  The first variable name
corresponds to the predicted outcome mean. The second name corresponds to fixed effects. 

{pmore}
When {cmd:replace} is used, variables with the names in {it:varlist} or
{it:stub}{cmd:*} are replaced by those in the new computation.  If
{cmd:noai} is specified, only a variable for the mean
is created.  

{phang}{opt nodots} suppress iteration dots.

{phang} {opt level(#)} set confidence level; default is {cmd:level(95)}.

{phang}{opt fast} speeds up using mata functions.

{phang}{opt tenfoldcv} specifies using ten-fold CV instead of LSCV.  


{title:Requirement}

{pstd}{opt xtplfc} can only be used if data are declared to be panel
data through the {helpb xtset} or {helpb tsset} command.  Before using 
{opt xtplfc}, you must install {opt bspline} and {opt moremata}.


{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:.} {bf:{stata "clear"}}{p_end}
{phang2}{cmd:.} {bf:{stata "set obs 50"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen a=rnormal()"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen id=_n"}}{p_end}
{phang2}{cmd:.} {bf:{stata "expand 100"}}{p_end}
{phang2}{cmd:.} {bf:{stata "bys id: gen year=_n"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen x=10*runiform()"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen z=5+2*rnormal()"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen u=-3+20*runiform()"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen gf1=sin(_pi/3*u)"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen y=a+1.2*x+z*gf1+sqrt(2)*rnormal()"}}{p_end}
{phang2}{cmd:.} {bf:{stata "xtset id year"}}{p_end}

{pstd}Fixed-effects semiparametric regression with 10 knots specified.{p_end}

{phang2}{cmd:.} {bf:{stata "xtplfc y x, zvars(z) uvar(u) gen(g) nknots(10)"}}{p_end}

{pstd}Fixed-effects semiparametric regression with optimal knots determined by the rule of leave-one-out CV{p_end}

{phang2}{cmd:.} {bf:{stata "xtplfc y x, zvars(z) uvar(u) gen(f) maxnknots(20)"}}{p_end}

{pstd}Compute the 95% CI for the functional coefficient {p_end}

{phang2}{cmd:.} {bf:{stata "gen lb=f_1-1.96*f_1_sd"}}{p_end}
{phang2}{cmd:.} {bf:{stata "gen ub=f_1+1.96*f_1_sd"}}{p_end}

{pstd}Plot the fitted values of the functional coefficient{p_end}

{phang2}{cmd:.} {bf:{stata "local plot1 line gf1 u, sort"}}{p_end}
{phang2}{cmd:.} {bf:{stata "local plot2 line f_1 u, sort"}}{p_end}
{phang2}{cmd:.} {bf:{stata "local plot3 rarea lb ub u, color(gs12) sort"}}{p_end}
{phang2}{cmd:.} {bf:{stata `"twoway (`plot3') (`plot1') (`plot2' legend(label(1 "95% CI") label(2 "Real values") label(3 "Fitted values")))"'}}{p_end}

 

{title:Saved results}

{pstd}
{cmd:xtplfc} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(r2)}}within R-squared{p_end}
{synopt:{cmd:e(r2_a)}}adjusted within R-squared{p_end}
{synopt:{cmd:e(rmse)}}root mean squared error{p_end}
{synopt:{cmd:e(mss)}}model sum of squares{p_end}
{synopt:{cmd:e(rss)}}residual sum of squares{p_end}


{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtplfc}{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(estfun)}}variables storing the estimated functional coefficients{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(vcetype)}}type of variance-covariance{p_end}
{synopt:{cmd:e(model)}}{cmd:Fixed-effect Series Semiparametric Estimation}{p_end}
{synopt:{cmd:e(k#)}}list of knots for the #th function{p_end}



{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(nknots)}}number of knots{p_end}
{synopt:{cmd:e(power)}}power (or degree) of splines{p_end}
{synopt:{cmd:e(b)}}coefficient vector in the linear part{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators in the linear part{p_end}
{synopt:{cmd:e(bs)}}coefficient vector in the approximating model{p_end}
{synopt:{cmd:e(Vs)}}variance-covariance matrix of the estimators in the approximating model{p_end}


{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{phang}
An, Y., H. Cheng, D. Li. 2016. Semiparametric estimation of partially linear varying coefficient panel data models. {it: Advances in Econometrics} 36: 47-65.

{phang}Baltagi, B. H., and D. Li.  2002.  Series estimation of partially
linear panel data models with fixed effects. 
{it:Annals of Economics and Finance} 3: 103-116.

{phang}Du, K., Zhang, Y. and Zhou, Q. 2019. {browse "https://github.com/kerrydu/xtplfc_Stata/blob/master/manuscript.pdf":Estimating partially linear functional-coefficient panel data models with Stata}. 
{it:Working Paper} 

{phang}
Libois, F. and V. Verardi. 2013. Semiparametric fixed-effects estimator. {it:Stata Journal} 13: 329-336.

{phang}
Newson, R.  2000.  B-splines and splines parameterized by their
values at reference points on the x-axis. 
{browse "http://www.stata.com/products/stb/journals/stb57.pdf":{it:Stata Technical Bulletin} 57}: 20-27.  Reprinted in 
{it:Stata Technical Bulletin Reprints}, vol. 10, pp. 221-230. 

{phang}
Zhang, Y., and Q. Zhou. 2018. Partially linear functional-coefficient panel data models: Sieve Estimation and Specification testing. {it:Working paper}.



{title:Author}

{pstd}
Kerry Du{break}
School of Management{break}
Xiamen University{break}
Xiamen, China{break}
{browse "mailto:kerrydu@xmu.edu.cn":kerrydu@xmu.edu.cn}

{pstd}
Yonghui Zhang{break}
School of Economics{break}
Renmin University of China{break}
Beijing, China{break}
{browse "mailto:yonghui.zhang@hotmail.com":yonghui.zhang@hotmail.com}

{pstd}
Qiankun Zhou{break}
Department of Economics{break}
Renmin University of China{break}
Baton Rouge,USA{break}
{browse "mailto:qzhou@lsu.edu":qzhou@lsu.edu}


{title:Also see}

{p 7 14 2}Help:  {helpb xtsemipar}, {helpb bspline} (if installed){p_end}
