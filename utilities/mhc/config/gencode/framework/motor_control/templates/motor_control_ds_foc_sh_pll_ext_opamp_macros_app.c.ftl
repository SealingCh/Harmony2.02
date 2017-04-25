<#-- motor_control_ds_foc_sh_pll_ext_opamp_macros_app.c.ftl -->

<#--
// *****************************************************************************
// Section: Included Files 
// *****************************************************************************

#include "${APP_NAME?lower_case}.h"
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_includes>
</#macro>

<#--
// *****************************************************************************
// *****************************************************************************
// Section: Global Data Definitions
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Application Data
*/
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_global_data>

/* MC Core Variables */
#define 	SQRT3_BY2     			(float)0.866025403788
#define 	ONE_BY_SQRT3     		(float)0.5773502691

tPIParm     						PIParmQ;        						/* parms for PI controlers */
tPIParm     						PIParmD;        						/* parms for PI controlers */
tPIParm     						PIParmQref;     						/* parms for PI controlers */
tParkParm							ParkParm;   
tSincosParm							SincosParm;
tSVGenParm 							SVGenParm;
tCtrlParm 						    CtrlParm;

float 								T1, T2, Ta, Tb, Tc;
float 								dPWM1, dPWM2, dPWM3;
float 								Startup_Ramp_Angle_Rads_Per_Sec = 0; 	/* ramp angle variable for initial ramp */
unsigned int 						Startup_Lock_Count = 0; 				/* lock variable for initial ramp */ 

extern short 						potReading;
short 								POLARITY;
float 								DoControl_Temp1, DoControl_Temp2;

/* MC Estimator Variables */
tEstimParm 							EstimParm;
tMotorEstimParm 					MotorEstimParm;
#define 							DECIMATE_NOMINAL_SPEED      ((NOMINAL_SPEED_RPM *(M_PI/30))*NOPOLESPAIRS/10)                                            

const float sineTable[TABLE_SIZE] = 
{
0,
0.024541,
0.049068,
0.073565,
0.098017,
0.122411,
0.14673,
0.170962,
0.19509,
0.219101,
0.24298,
0.266713,
0.290285,
0.313682,
0.33689,
0.359895,
0.382683,
0.405241,
0.427555,
0.449611,
0.471397,
0.492898,
0.514103,
0.534998,
0.55557,
0.575808,
0.595699,
0.615232,
0.634393,
0.653173,
0.671559,
0.689541,
0.707107,
0.724247,
0.740951,
0.757209,
0.77301,
0.788346,
0.803208,
0.817585,
0.83147,
0.844854,
0.857729,
0.870087,
0.881921,
0.893224,
0.903989,
0.91421,
0.92388,
0.932993,
0.941544,
0.949528,
0.95694,
0.963776,
0.970031,
0.975702,
0.980785,
0.985278,
0.989177,
0.99248,
0.995185,
0.99729,
0.998795,
0.999699,
1,
0.999699,
0.998795,
0.99729,
0.995185,
0.99248,
0.989177,
0.985278,
0.980785,
0.975702,
0.970031,
0.963776,
0.95694,
0.949528,
0.941544,
0.932993,
0.92388,
0.91421,
0.903989,
0.893224,
0.881921,
0.870087,
0.857729,
0.844854,
0.83147,
0.817585,
0.803208,
0.788346,
0.77301,
0.757209,
0.740951,
0.724247,
0.707107,
0.689541,
0.671559,
0.653173,
0.634393,
0.615232,
0.595699,
0.575808,
0.55557,
0.534998,
0.514103,
0.492898,
0.471397,
0.449611,
0.427555,
0.405241,
0.382683,
0.359895,
0.33689,
0.313682,
0.290285,
0.266713,
0.24298,
0.219101,
0.19509,
0.170962,
0.14673,
0.122411,
0.098017,
0.073565,
0.049068,
0.024541,
0,
-0.024541,
-0.049068,
-0.073565,
-0.098017,
-0.122411,
-0.14673,
-0.170962,
-0.19509,
-0.219101,
-0.24298,
-0.266713,
-0.290285,
-0.313682,
-0.33689,
-0.359895,
-0.382683,
-0.405241,
-0.427555,
-0.449611,
-0.471397,
-0.492898,
-0.514103,
-0.534998,
-0.55557,
-0.575808,
-0.595699,
-0.615232,
-0.634393,
-0.653173,
-0.671559,
-0.689541,
-0.707107,
-0.724247,
-0.740951,
-0.757209,
-0.77301,
-0.788346,
-0.803208,
-0.817585,
-0.83147,
-0.844854,
-0.857729,
-0.870087,
-0.881921,
-0.893224,
-0.903989,
-0.91421,
-0.92388,
-0.932993,
-0.941544,
-0.949528,
-0.95694,
-0.963776,
-0.970031,
-0.975702,
-0.980785,
-0.985278,
-0.989177,
-0.99248,
-0.995185,
-0.99729,
-0.998795,
-0.999699,
-1,
-0.999699,
-0.998795,
-0.99729,
-0.995185,
-0.99248,
-0.989177,
-0.985278,
-0.980785,
-0.975702,
-0.970031,
-0.963776,
-0.95694,
-0.949528,
-0.941544,
-0.932993,
-0.92388,
-0.91421,
-0.903989,
-0.893224,
-0.881921,
-0.870087,
-0.857729,
-0.844854,
-0.83147,
-0.817585,
-0.803208,
-0.788346,
-0.77301,
-0.757209,
-0.740951,
-0.724247,
-0.707107,
-0.689541,
-0.671559,
-0.653173,
-0.634393,
-0.615232,
-0.595699,
-0.575808,
-0.55557,
-0.534998,
-0.514103,
-0.492898,
-0.471397,
-0.449611,
-0.427555,
-0.405241,
-0.382683,
-0.359895,
-0.33689,
-0.313682,
-0.290285,
-0.266713,
-0.24298,
-0.219101,
-0.19509,
-0.170962,
-0.14673,
-0.122411,
-0.098017,
-0.073565,
-0.049068,
-0.024541
};

const float cosineTable[TABLE_SIZE] = 
{
1,
0.999699,
0.998795,
0.99729,
0.995185,
0.99248,
0.989177,
0.985278,
0.980785,
0.975702,
0.970031,
0.963776,
0.95694,
0.949528,
0.941544,
0.932993,
0.92388,
0.91421,
0.903989,
0.893224,
0.881921,
0.870087,
0.857729,
0.844854,
0.83147,
0.817585,
0.803208,
0.788346,
0.77301,
0.757209,
0.740951,
0.724247,
0.707107,
0.689541,
0.671559,
0.653173,
0.634393,
0.615232,
0.595699,
0.575808,
0.55557,
0.534998,
0.514103,
0.492898,
0.471397,
0.449611,
0.427555,
0.405241,
0.382683,
0.359895,
0.33689,
0.313682,
0.290285,
0.266713,
0.24298,
0.219101,
0.19509,
0.170962,
0.14673,
0.122411,
0.098017,
0.073565,
0.049068,
0.024541,
0,
-0.024541,
-0.049068,
-0.073565,
-0.098017,
-0.122411,
-0.14673,
-0.170962,
-0.19509,
-0.219101,
-0.24298,
-0.266713,
-0.290285,
-0.313682,
-0.33689,
-0.359895,
-0.382683,
-0.405241,
-0.427555,
-0.449611,
-0.471397,
-0.492898,
-0.514103,
-0.534998,
-0.55557,
-0.575808,
-0.595699,
-0.615232,
-0.634393,
-0.653173,
-0.671559,
-0.689541,
-0.707107,
-0.724247,
-0.740951,
-0.757209,
-0.77301,
-0.788346,
-0.803208,
-0.817585,
-0.83147,
-0.844854,
-0.857729,
-0.870087,
-0.881921,
-0.893224,
-0.903989,
-0.91421,
-0.92388,
-0.932993,
-0.941544,
-0.949528,
-0.95694,
-0.963776,
-0.970031,
-0.975702,
-0.980785,
-0.985278,
-0.989177,
-0.99248,
-0.995185,
-0.99729,
-0.998795,
-0.999699,
-1,
-0.999699,
-0.998795,
-0.99729,
-0.995185,
-0.99248,
-0.989177,
-0.985278,
-0.980785,
-0.975702,
-0.970031,
-0.963776,
-0.95694,
-0.949528,
-0.941544,
-0.932993,
-0.92388,
-0.91421,
-0.903989,
-0.893224,
-0.881921,
-0.870087,
-0.857729,
-0.844854,
-0.83147,
-0.817585,
-0.803208,
-0.788346,
-0.77301,
-0.757209,
-0.740951,
-0.724247,
-0.707107,
-0.689541,
-0.671559,
-0.653173,
-0.634393,
-0.615232,
-0.595699,
-0.575808,
-0.55557,
-0.534998,
-0.514103,
-0.492898,
-0.471397,
-0.449611,
-0.427555,
-0.405241,
-0.382683,
-0.359895,
-0.33689,
-0.313682,
-0.290285,
-0.266713,
-0.24298,
-0.219101,
-0.19509,
-0.170962,
-0.14673,
-0.122411,
-0.098017,
-0.073565,
-0.049068,
-0.024541,
0,
0.024541,
0.049068,
0.073565,
0.098017,
0.122411,
0.14673,
0.170962,
0.19509,
0.219101,
0.24298,
0.266713,
0.290285,
0.313682,
0.33689,
0.359895,
0.382683,
0.405241,
0.427555,
0.449611,
0.471397,
0.492898,
0.514103,
0.534998,
0.55557,
0.575808,
0.595699,
0.615232,
0.634393,
0.653173,
0.671559,
0.689541,
0.707107,
0.724247,
0.740951,
0.757209,
0.77301,
0.788346,
0.803208,
0.817585,
0.83147,
0.844854,
0.857729,
0.870087,
0.881921,
0.893224,
0.903989,
0.91421,
0.92388,
0.932993,
0.941544,
0.949528,
0.95694,
0.963776,
0.970031,
0.975702,
0.980785,
0.985278,
0.989177,
0.99248,
0.995185,
0.99729,
0.998795,
0.999699
};

</#macro>

<#--
// *****************************************************************************
// Section: Application Callback Functions
// *****************************************************************************
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_callback_functions>
</#macro>

<#--
// *****************************************************************************
// Section: Application Local Functions
// *****************************************************************************
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_local_functions>

// *****************************************************************************
// *****************************************************************************
// Section: MC Peripheral Initialization Functions
// *****************************************************************************
// *****************************************************************************
void ${APP_NAME?upper_case}_PWM_Initialize(void)
{
    PTCON = 0x0000;   

    PDC1 = (PWM_RELOAD_CENTER * 0.0);
    PDC2 = (PWM_RELOAD_CENTER * 0.0);
    PDC3 = (PWM_RELOAD_CENTER * 0.0);

    /* Set PWM Period */
    PTPER = PWM_RELOAD_CENTER;

    /* Set the Deadtime */
    DTR1 = DTR2 = DTR3 = DEADTIME_REG;
    ALTDTR1 = ALTDTR2 = ALTDTR3 = DEADTIME_REG;
     
    IOCON1 = IOCON2 = IOCON3 = PWM_IOCON_CONFIG; //CMP3 as fault input, cycle by cycle fault mode
   
    /* Set Independent Time Bases, Center-Aligned mode and Master Duty Cycles */
    PWMCON1 = PWMCON2 = PWMCON3 = 0x00800400; // PWM in Symmetric Center Aligned Mode with FLT interrupt enabled
    // Trigger ADC using PWM1, when PWML1 is center of ON
    // trigger slightly before the PTPER, otherwise, interrupt does not occur
    TRIG1 = (PWM_RELOAD_CENTER - 1);
    TRGCON1bits.TRGDIV = 0;
    TRGCON1bits.TRGSEL = 2; // generate trigger in incrementing phase (right hand side)
    TRGCON1bits.STRGSEL = 0;
    TRGCON1bits.DTM = 0;
    PLIB_INT_SourceFlagClear(INT_ID_0, INT_SOURCE_PWM1);
    PLIB_INT_SourceEnable(INT_ID_0, INT_SOURCE_PWM1);
    PLIB_INT_VectorPrioritySet(INT_ID_0, INT_SOURCE_PWM1, INT_PRIORITY_LEVEL4);
    PLIB_INT_VectorSubPrioritySet(INT_ID_0, INT_SOURCE_PWM1, INT_SUBPRIORITY_LEVEL0);      
}

void ${APP_NAME?upper_case}_PWM_Enable(void)
{
    PTCON=0x8000;
}

void ${APP_NAME?upper_case}_PWM_Disable(void)
{
    PTCON = 0x0000;
}

// *****************************************************************************
// *****************************************************************************
// Section: MC PLL Estimator Routines
// *****************************************************************************
// *****************************************************************************
void ${APP_NAME?upper_case}_MC_Estim(void)
{
	float tempqVelEstim;
    
    if(EstimParm.qVelEstim < 0)
    {
        tempqVelEstim = EstimParm.qVelEstim * (-1);    
    }
    else
    {
        tempqVelEstim = EstimParm.qVelEstim;
    }
    
	EstimParm.qDIalpha	=	(ParkParm.Ialpha-EstimParm.qLastIalpha);
    EstimParm.qVIndalpha = (MotorEstimParm.qLsDt * EstimParm.qDIalpha);
    EstimParm.qDIbeta	=	(ParkParm.Ibeta-EstimParm.qLastIbeta);
    EstimParm.qVIndbeta= (MotorEstimParm.qLsDt * EstimParm.qDIbeta);
    
    // Update LastIalpha and LastIbeta
    EstimParm.qLastIalpha	=	ParkParm.Ialpha;
    EstimParm.qLastIbeta 	=	ParkParm.Ibeta;
    
    // Stator voltage eqations
 	EstimParm.qEsa		= 	EstimParm.qLastValpha -
							((MotorEstimParm.qRs  * ParkParm.Ialpha))
							- EstimParm.qVIndalpha;
							
 	EstimParm.qEsb		= 	EstimParm.qLastVbeta -
							((MotorEstimParm.qRs  * ParkParm.Ibeta ))
							- EstimParm.qVIndbeta;
    
    // Update LastValpha and LastVbeta
	EstimParm.qLastValpha = (ParkParm.halfDCBusVoltage * ParkParm.Valpha);
	EstimParm.qLastVbeta = (ParkParm.halfDCBusVoltage * ParkParm.Vbeta);

    // Calculate Sin(Rho) and Cos(Rho)
    SincosParm.Angle 	=	EstimParm.qRho + EstimParm.RhoOffset; 

    if(SincosParm.Angle <= 0) //SINGLE_ELEC_ROT_RADS_PER_SEC)
        SincosParm.Angle = SincosParm.Angle + SINGLE_ELEC_ROT_RADS_PER_SEC; 
    if(SincosParm.Angle >= SINGLE_ELEC_ROT_RADS_PER_SEC)
        SincosParm.Angle = SincosParm.Angle - SINGLE_ELEC_ROT_RADS_PER_SEC; 
  
	${APP_NAME?upper_case}_MC_SinCos();

    // Translate Back EMF (Alpha,beta)  ESA, ESB to Back EMF(D,Q) ESD, ESQ using Park Transform. 
    EstimParm.qEsd		=	((EstimParm.qEsa * SincosParm.Cos))
							+
							((EstimParm.qEsb * SincosParm.Sin));
    
	EstimParm.qEsq		=	(( EstimParm.qEsb * SincosParm.Cos))
							-
							((EstimParm.qEsa * SincosParm.Sin));

    // Filter first order for Esd and Esq
	EstimParm.qEsdf			= EstimParm.qEsdf+
							  ((EstimParm.qEsd - EstimParm.qEsdf) * EstimParm.qKfilterEsdq) ;

	EstimParm.qEsqf			= EstimParm.qEsqf+
							  ((EstimParm.qEsq - EstimParm.qEsqf) * EstimParm.qKfilterEsdq) ;
      
	if (tempqVelEstim>DECIMATE_NOMINAL_SPEED)
    {
    	if(EstimParm.qEsqf>0)
    	{
    		EstimParm.qOmegaMr	=	((MotorEstimParm.qInvKFi*(EstimParm.qEsqf- EstimParm.qEsdf))) ;
    	} 
		else
    	{
    		EstimParm.qOmegaMr	=	((MotorEstimParm.qInvKFi*(EstimParm.qEsqf + EstimParm.qEsdf)));
    	}
    } 
	else // if est speed<10% => condition VelRef<>0
    {
    	if(EstimParm.qVelEstim>0)
    	{
    		EstimParm.qOmegaMr	=	((MotorEstimParm.qInvKFi*(EstimParm.qEsqf- EstimParm.qEsdf))) ;
    	} 
		else
    	{
    		EstimParm.qOmegaMr	=	((MotorEstimParm.qInvKFi*(EstimParm.qEsqf+ EstimParm.qEsdf))) ;
    	}
    }
    	
	// The integral of the angle is the estimated angle */
	EstimParm.qRho	= 	EstimParm.qRho+
							(EstimParm.qOmegaMr)*(EstimParm.qDeltaT);
    
    if(EstimParm.qRho >= SINGLE_ELEC_ROT_RADS_PER_SEC)
        EstimParm.qRho = EstimParm.qRho - SINGLE_ELEC_ROT_RADS_PER_SEC;      

     if(EstimParm.qRho <= 0)// SINGLE_ELEC_ROT_RADS_PER_SEC)
        EstimParm.qRho = EstimParm.qRho + SINGLE_ELEC_ROT_RADS_PER_SEC; 
    

    // The estimated speed is a filter value of the above calculated OmegaMr. The filter implementation
    // is the same as for BEMF d-q components filtering
	EstimParm.qVelEstim = (EstimParm.qVelEstim+
						( (EstimParm.qOmegaMr-EstimParm.qVelEstim)*EstimParm.qVelEstimFilterK ));
}

void ${APP_NAME?upper_case}_MC_InitEstimParm(void)  
{
	MotorEstimParm.qLsDt = (float)(MOTOR_PER_PHASE_INDUCTANCE/LOOPTIME_SEC);
	MotorEstimParm.qRs = MOTOR_PER_PHASE_RESISTANCE;
	
	MotorEstimParm.qInvKFi = (float)(1/MOTOR_BACK_EMF_CONSTANT_Vpeak_PHASE_RAD_PER_SEC_ELEC);

   	EstimParm.qRhoStateVar=0;
	EstimParm.qOmegaMr=0;
	 
    EstimParm.qKfilterEsdq = KFILTER_ESDQ;
    EstimParm.qVelEstimFilterK = KFILTER_VELESTIM;

    EstimParm.qDeltaT = 0.00005;
    EstimParm.RhoOffset = (45 * (M_PI/180));
}

// *****************************************************************************
// *****************************************************************************
// Section: MC Core Routines
// *****************************************************************************
// *****************************************************************************
void ${APP_NAME?upper_case}_MC_InvPark(void)
{
    ParkParm.Valpha =  ParkParm.Vd*ParkParm.Cos - ParkParm.Vq*ParkParm.Sin;
    ParkParm.Vbeta  =  ParkParm.Vd*ParkParm.Sin + ParkParm.Vq*ParkParm.Cos;       
}

void ${APP_NAME?upper_case}_MC_CalcRefVec(void) // rotates the motor in clockwise direction
{
    SVGenParm.Vr1 = ParkParm.Vbeta;
    SVGenParm.Vr2 = (-ParkParm.Vbeta/2 + SQRT3_BY2 * ParkParm.Valpha);
    SVGenParm.Vr3 = (-ParkParm.Vbeta/2 - SQRT3_BY2 * ParkParm.Valpha);       
} 

void ${APP_NAME?upper_case}_MC_Clarke(void)
{
    ParkParm.Ialpha = ParkParm.Ia;
    ParkParm.Ibeta = (ParkParm.Ia * ONE_BY_SQRT3) + (ParkParm.Ib * 2 * ONE_BY_SQRT3);
}

void ${APP_NAME?upper_case}_MC_Park(void)
{
    ParkParm.Id =  ParkParm.Ialpha*ParkParm.Cos + ParkParm.Ibeta*ParkParm.Sin;
    ParkParm.Iq = -ParkParm.Ialpha*ParkParm.Sin + ParkParm.Ibeta*ParkParm.Cos;
}

void ${APP_NAME?upper_case}_MC_InitControlParameters(void)
{
	// PI D Term     
    PIParmD.qKp = D_CURRCNTR_PTERM;       
    PIParmD.qKi = D_CURRCNTR_ITERM;              
    PIParmD.qKc = D_CURRCNTR_CTERM;       
    PIParmD.qOutMax = D_CURRCNTR_OUTMAX;
    PIParmD.qOutMin = -PIParmD.qOutMax;

    ${APP_NAME?upper_case}_MC_InitPI(&PIParmD);

    // PI Q Term 
    PIParmQ.qKp = Q_CURRCNTR_PTERM;    
    PIParmQ.qKi = Q_CURRCNTR_ITERM;
    PIParmQ.qKc = Q_CURRCNTR_CTERM;
    PIParmQ.qdSum = 0;
    PIParmQ.qOutMax = Q_CURRCNTR_OUTMAX;
    PIParmQ.qOutMin = -PIParmQ.qOutMax;

    ${APP_NAME?upper_case}_MC_InitPI(&PIParmQ);

    // PI Qref Term
    PIParmQref.qKp = SPEEDCNTR_PTERM;       
    PIParmQref.qKi = SPEEDCNTR_ITERM;       
    PIParmQref.qKc = SPEEDCNTR_CTERM;       
    PIParmQref.qOutMax = SPEEDCNTR_OUTMAX;   
    PIParmQref.qOutMin = -PIParmQref.qOutMax;

    ${APP_NAME?upper_case}_MC_InitPI(&PIParmQref);
	return;
}

void ${APP_NAME?upper_case}_MC_InitPI( tPIParm *pParm)
{
    pParm->qdSum = 0;
    pParm->qOut = 0;
}

void ${APP_NAME?upper_case}_MC_CalcPI( tPIParm *pParm)
{
    float Err;
    float U;
    float Exc;
    
    Err  = pParm->qInRef - pParm->qInMeas;
    pParm->qErr =  Err; 
    U  = pParm->qdSum + pParm->qKp * Err;
   
    if( U > pParm->qOutMax )
    {
        pParm->qOut = pParm->qOutMax;
    }    
    else if( U < pParm->qOutMin )
    {
        pParm->qOut = pParm->qOutMin;
    }
    else        
    {
        pParm->qOut = U;  
    }
     
    Exc = U - pParm->qOut;
    pParm->qdSum = pParm->qdSum + pParm->qKi * Err - pParm->qKc * Exc;

}

void ${APP_NAME?upper_case}_MC_SinCos(void)
{
    // IMPORTANT:
    // DO NOT PASS "SincosParm.angle" > 2*PI. There is no software check
    
    // Since we are using "float", it is not possible to get an index of array
    // directly. Almost every time, we will need to do interpolation, as per
    // following equation: -
    // y = y0 + (y1 - y0)*((x - x0)/(x1 - x0))
    
    uint32_t y0_Index;
    uint32_t y0_IndexNext;
    float x0, x1, y0, y1, temp;
    
    y0_Index = (uint32_t)(SincosParm.Angle/ANGLE_STEP);
    
	//Added this condition which detects if y0_Index is >=256.
    //Earlier the only check was for y0_IndexNext. 
    //We observed y0_Index > = 256 when the code to reverse the direction of the motor was added
    if(y0_Index>=TABLE_SIZE)
    {
        y0_Index = 0;
        y0_IndexNext = 1;
        x0 = TOTAL_SINE_TABLE_ANGLE;
        x1 = ANGLE_STEP;
        temp = 0;
    }
    else
    {
        y0_IndexNext = y0_Index + 1;
        if(y0_IndexNext >= TABLE_SIZE )
        {
            y0_IndexNext = 0;
            x1 = TOTAL_SINE_TABLE_ANGLE;
        }
        else
        {
            x1 = ((y0_IndexNext) * ANGLE_STEP);
        }

        x0 = (y0_Index * ANGLE_STEP);  
    
    
    // Since below calculation is same for sin & cosine, we can do it once and reuse
    
	temp = ((SincosParm.Angle - x0)/(x1 - x0));
    }
    
	// Find Sine now
    y0 = sineTable[y0_Index];
    y1 = sineTable[y0_IndexNext];     
    SincosParm.Sin = y0 + ((y1 - y0)*temp);
	
    // Find Cosine now
    y0 = cosineTable[y0_Index];
    y1 = cosineTable[y0_IndexNext];
    SincosParm.Cos = y0 + ((y1 - y0)*temp);
}

void ${APP_NAME?upper_case}_MC_CalcTimes(void)
{
    T1 = SVGenParm.PWMPeriod * T1;
    T2 = SVGenParm.PWMPeriod * T2;
    Tc = (SVGenParm.PWMPeriod-T1-T2)/2;
    Tb = Tc + T2;
    Ta = Tb + T1;    
}  

void ${APP_NAME?upper_case}_MC_CalcSVGen( void )
{
    if( SVGenParm.Vr1 >= 0 )
    {       
		// (xx1)
        if( SVGenParm.Vr2 >= 0 )
        {
            // (x11)
            // Must be Sector 3 since Sector 7 not allowed
            // Sector 3: (0,1,1)  0-60 degrees
            T1 = SVGenParm.Vr2;
            T2 = SVGenParm.Vr1;
            ${APP_NAME?upper_case}_MC_CalcTimes();
            dPWM1 = Ta;
            dPWM2 = Tb;
            dPWM3 = Tc;
        }
        else
        {            
            // (x01)
            if( SVGenParm.Vr3 >= 0 )
            {
                // Sector 5: (1,0,1)  120-180 degrees
                T1 = SVGenParm.Vr1;
                T2 = SVGenParm.Vr3;
                ${APP_NAME?upper_case}_MC_CalcTimes();
                dPWM1 = Tc;
                dPWM2 = Ta;
                dPWM3 = Tb;
            }
            else
            {
                // Sector 1: (0,0,1)  60-120 degrees
                T1 = -SVGenParm.Vr2;
                T2 = -SVGenParm.Vr3;
                ${APP_NAME?upper_case}_MC_CalcTimes();
                dPWM1 = Tb;
                dPWM2 = Ta;
                dPWM3 = Tc;
            }
        }
    }
    else
    {
        // (xx0)
        if( SVGenParm.Vr2 >= 0 )
        {
			// (x10)
            if( SVGenParm.Vr3 >= 0 )
            {
                // Sector 6: (1,1,0)  240-300 degrees
                T1 = SVGenParm.Vr3;
                T2 = SVGenParm.Vr2;
                ${APP_NAME?upper_case}_MC_CalcTimes();
                dPWM1 = Tb;
                dPWM2 = Tc;
                dPWM3 = Ta;
            }
            else
            {
                // Sector 2: (0,1,0)  300-0 degrees
                T1 = -SVGenParm.Vr3;
                T2 = -SVGenParm.Vr1;
                ${APP_NAME?upper_case}_MC_CalcTimes();
                dPWM1 = Ta;
                dPWM2 = Tc;
                dPWM3 = Tb;
            }
        }
        else
        {            
            // (x00)
            // Must be Sector 4 since Sector 0 not allowed
            // Sector 4: (1,0,0)  180-240 degrees
            T1 = -SVGenParm.Vr1;
            T2 = -SVGenParm.Vr2;
            ${APP_NAME?upper_case}_MC_CalcTimes();
            dPWM1 = Tc;
            dPWM2 = Tb;
            dPWM3 = Ta;

        }
    }
}

void ${APP_NAME?upper_case}_MC_CalculateParkAngle(void)
{
    // If open loop
	if(${APP_NAME?upper_case}_MC_CONTROL.bit.OpenLoop)	
	{
		// begin with the lock sequence, for field alignment. The rotor is locked at angle = 0 for LOCK_COUNT_FOR_LOCK_TIME ~ 2 seconds
		if (Startup_Lock_Count < LOCK_COUNT_FOR_LOCK_TIME)
			Startup_Lock_Count++;
	    // then ramp up till the end speed
		else if (Startup_Ramp_Angle_Rads_Per_Sec < END_SPEED_RADS_PER_SEC_ELEC_IN_LOOPTIME)
			Startup_Ramp_Angle_Rads_Per_Sec+=OPENLOOP_RAMPSPEED_INCREASERATE;
		else // switch to closed loop
		{
#ifndef OPEN_LOOP_FUNCTIONING
            ${APP_NAME?upper_case}_MC_CONTROL.bit.ChangeMode = 1;
            ${APP_NAME?upper_case}_MC_CONTROL.bit.OpenLoop = 0;
#endif
		}
		
		// the angle set depends on startup ramp
		ParkParm.Angle += Startup_Ramp_Angle_Rads_Per_Sec;
        
        if(ParkParm.Angle >= SINGLE_ELEC_ROT_RADS_PER_SEC)
            ParkParm.Angle = ParkParm.Angle - SINGLE_ELEC_ROT_RADS_PER_SEC;        
	}
	else // switched to closed loop
	{
   	    // in closed loop slowly decrease the offset add to the estimated angle
   	    if(EstimParm.RhoOffset>(M_PI/(float)32767))
            EstimParm.RhoOffset = EstimParm.RhoOffset - ((M_PI/(float)32767)) ; 
	}
	return;
}

void ${APP_NAME?upper_case}_MC_DoControl( void )
{
    // Snap vars updated for both SNAPSHOT and RTDM
    ${APP_NAME?upper_case}_MC_DBG_SnapUpdate();
	  
    if( ${APP_NAME?upper_case}_MC_CONTROL.bit.OpenLoop )
    {
        // OPENLOOP:  force rotating angle,Vd,Vq
        if( ${APP_NAME?upper_case}_MC_CONTROL.bit.ChangeMode )
        {
            // just changed to openloop
            ${APP_NAME?upper_case}_MC_CONTROL.bit.ChangeMode = 0;
            // synchronize angles

            // VqRef & VdRef not used
            CtrlParm.qVqRef = 0;
            CtrlParm.qVdRef = 0;

			// reinit vars for initial speed ramp
			Startup_Lock_Count = 0;
			Startup_Ramp_Angle_Rads_Per_Sec = 0;
        }
        
        // q current reference is equal to the vel reference
        // while d current reference is equal to 0
        // for maximum startup torque, set the q current to maximum acceptable
        // value represents the maximum peak value
        CtrlParm.qVqRef    = Q_CURRENT_REF_OPENLOOP;
       	
        // PI control for Q
        PIParmQ.qInMeas = ParkParm.Iq;
        PIParmQ.qInRef  = CtrlParm.qVqRef;
        ${APP_NAME?upper_case}_MC_CalcPI(&PIParmQ);
        ParkParm.Vq = PIParmQ.qOut;
       
        // PI control for D
        PIParmD.qInMeas = ParkParm.Id;
        PIParmD.qInRef  = CtrlParm.qVdRef;
        ${APP_NAME?upper_case}_MC_CalcPI(&PIParmD);
        ParkParm.Vd = PIParmD.qOut;
    } 
    else
    // Closed Loop Vector Control
	{ 
        PLIB_PORTS_PinSet(PORTS_ID_0, PORT_CHANNEL_F,PORTS_BIT_POS_5);
        
		if( ${APP_NAME?upper_case}_MC_CONTROL.bit.ChangeMode )
        {
            // just changed from openloop
            ${APP_NAME?upper_case}_MC_CONTROL.bit.ChangeMode = 0;
			PIParmQref.qdSum = CtrlParm.qVqRef;
            CtrlParm.qVelRef = END_SPEED_RADS_PER_SEC_ELEC;
            PIParmD.qInRef = 0.0;
            CtrlParm.qVdRef = 0.0;
            PIParmD.qKi = D_CURRCNTR_ITERM/10;
            PIParmQ.qKi = Q_CURRCNTR_ITERM/10;   
        }             
        
        // Since we are not using a potentiometer, we use the following logic to send speed command and vary idref
        CtrlParm.qVelRef =(float)((float)potReading * POT_ADC_COUNT_FW_SPEED_RATIO);
        
		if(CtrlParm.qVelRef < END_SPEED_RADS_PER_SEC_ELEC)
        {
            CtrlParm.qVelRef = END_SPEED_RADS_PER_SEC_ELEC;
        }
        
        // Calculate qVdRef from motor equation in d/q frame (steady state assumption, ignore Ls*(di/dt)
        ParkParm.FW_Vd = (MOTOR_PER_PHASE_RESISTANCE * CtrlParm.qVdRef) - (EstimParm.qVelEstim * MOTOR_PER_PHASE_INDUCTANCE * CtrlParm.qVqRef);  

        DoControl_Temp2 = ParkParm.FW_Vd * ParkParm.FW_Vd;
        DoControl_Temp1 = (0.98 * ParkParm.halfDCBusVoltage * ParkParm.halfDCBusVoltage) - DoControl_Temp2;
        if(DoControl_Temp1 < 0)
            DoControl_Temp1 = 0;
        ParkParm.FW_Vq = sqrt(DoControl_Temp1);   

        if(CtrlParm.qVelRef > NOMINAL_SPEED_RAD_PER_SEC_ELEC)
        {    
         CtrlParm.qVdRef = (ParkParm.FW_Vq - (MOTOR_PER_PHASE_RESISTANCE * CtrlParm.qVqRef) - (CtrlParm.qVelRef  * MOTOR_BACK_EMF_CONSTANT_Vpeak_PHASE_RAD_PER_SEC_ELEC))/(CtrlParm.qVelRef  * MOTOR_PER_PHASE_INDUCTANCE);
        }
        else
        {
            CtrlParm.qVdRef = 0;
        }
        if(CtrlParm.qVdRef > 0)
            CtrlParm.qVdRef = 0; 
        
        if(CtrlParm.qVdRef < MAX_FW_NEGATIVE_ID_REF)
            CtrlParm.qVdRef = MAX_FW_NEGATIVE_ID_REF;
        
        //if TORQUE MODE skip the speed controller               
#ifndef	TORQUE_MODE
       	// Execute the velocity control loop
		PIParmQref.qInMeas = EstimParm.qVelEstim;
    	PIParmQref.qInRef  = CtrlParm.qVelRef;
    	${APP_NAME?upper_case}_MC_CalcPI(&PIParmQref);
    	CtrlParm.qVqRef = PIParmQref.qOut;

#else
        CtrlParm.qVqRef = Q_CURRENT_REF_OPENLOOP;
#endif
   
        // PI control for D
        PIParmD.qInMeas = ParkParm.Id;          // This is in Amps
        PIParmD.qInRef  = CtrlParm.qVdRef;      // This is in Amps
        ${APP_NAME?upper_case}_MC_CalcPI(&PIParmD);
        ParkParm.Vd    =  PIParmD.qOut;          // This is in %. If should be converted to volts, multiply with (DC/2)

        // dynamic d-q adjustment
        // with d component priority
        // vq=sqrt (vs^2 - vd^2)
        // limit vq maximum to the one resulting from the calculation above
        DoControl_Temp2 = PIParmD.qOut * PIParmD.qOut;
        DoControl_Temp1 = 0.98 - DoControl_Temp2;
        PIParmQ.qOutMax = sqrt(DoControl_Temp1);        
 
        // PI control for Q
        PIParmQ.qInMeas = ParkParm.Iq;          // This is in Amps
        PIParmQ.qInRef  = CtrlParm.qVqRef;      // This is in Amps
        ${APP_NAME?upper_case}_MC_CalcPI(&PIParmQ);
        ParkParm.Vq    = PIParmQ.qOut;          // This is in %. If should be converted to volts, multiply with (DC/2)       

    }
}

void ${APP_NAME?upper_case}_MC_Tasks (void )
{
    /* Check the application's current state. */
    switch ( ${APP_NAME?lower_case}Data.mcState )
    {
        /* Application's initial state. */
        case ${APP_NAME?upper_case}_MC_STATE_INIT:
        {
            if(!BTN1)
            {
                 ${APP_NAME?upper_case}_MC_CONTROL.bit.Btn1Pressed = 1;
            }
   
            if(${APP_NAME?lower_case}Data.classBState == ${APP_NAME?upper_case}_CLASSB_STATE_TEST_PASS & ${APP_NAME?upper_case}_MC_CONTROL.bit.Btn1Pressed == 1)
            {
				${APP_NAME?upper_case}_MC_CONTROL.bit.OpenLoop = 1;
				${APP_NAME?upper_case}_MC_CONTROL.bit.ChangeMode = 1;
				${APP_NAME?upper_case}_MC_InitControlParameters();
				${APP_NAME?upper_case}_MC_InitEstimParm();
				SincosParm.Angle = 0;
				SVGenParm.PWMPeriod = (float)MAX_DUTY;
				${APP_NAME?upper_case}_PWM_Enable();
				${APP_NAME?lower_case}Data.mcState = ${APP_NAME?upper_case}_MC_STATE_NOP;
            }
			
            break;
        }
		
        case ${APP_NAME?upper_case}_MC_STATE_NOP:
        {
            //Do Nothing in this state, ADC ISR will run the control algorithm
            break;
        }
               
        case ${APP_NAME?upper_case}_MC_STATE_STOP:
        {
            ${APP_NAME?upper_case}_PWM_Disable();
            break;
        }

        /* The default state should never be executed. */
        default:
        {
            break;
        }
    }
}
</#macro>

<#--
// *****************************************************************************
// Section: Application Initialization and State Machine Functions
// *****************************************************************************
// *****************************************************************************

/*******************************************************************************
  Function:
    void ${APP_NAME?upper_case}_Initialize ( void )

  Remarks:
    See prototype in ${APP_NAME?lower_case}.h.
 */

void ${APP_NAME?upper_case}_Initialize ( void )
{
    /* Place the App state machine in its initial state. */
    ${APP_NAME?lower_case}Data.state = ${APP_NAME?upper_case}_STATE_INIT;
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_initialize>
	/* Initialize PWM */
	${APP_NAME?upper_case}_PWM_Initialize();
	
</#macro>

<#--
}


/******************************************************************************
  Function:
    void ${APP_NAME?upper_case}_Tasks ( void )

  Remarks:
    See prototype in ${APP_NAME?lower_case}.h.
 */

void ${APP_NAME?upper_case}_Tasks ( void )
{
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_tasks_data>
</#macro>

<#--
    /* Check the application's current state. */
    switch ( ${APP_NAME?lower_case}Data.state )
    {
        /* Application's initial state. */
        case ${APP_NAME?upper_case}_STATE_INIT:
        {
            bool appInitialized = true;
-->   
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_tasks_state_init>
			DRV_ADC0_Open();
			DRV_ADC1_Open();
			DRV_ADC2_Open();
</#macro>    

<#--        
            if (appInitialized)
            {
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_tasks_calls_after_init>
</#macro>

<#--            /* Advance to the next state */
                ${APP_NAME?lower_case}Data.state = ${APP_NAME?upper_case}_STATE_SERVICE_TASKS;
            }
            break;
        }

        case ${APP_NAME?upper_case}_STATE_SERVICE_TASKS:
        {
-->
<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_tasks_state_service_tasks>
			${APP_NAME?upper_case}_MC_Tasks();
</#macro>

<#--        
            break;
        }

        /* The default state should never be executed. */
        default:
        {
            /* TODO: Handle error in application's state machine. */
            break;
        }
    }
}
-->

<#macro macro_motor_control_ds_foc_sh_pll_ext_opamp_app_c_tasks_states>
</#macro>
