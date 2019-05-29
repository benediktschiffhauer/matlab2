#ifndef __c2_V3_sim_h__
#define __c2_V3_sim_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc2_V3_simInstanceStruct
#define typedef_SFc2_V3_simInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_V3_sim;
  real_T c2_i;
  boolean_T c2_i_not_empty;
  real_T c2_last;
  boolean_T c2_last_not_empty;
  void *c2_fEmlrtCtx;
  real_T *c2_t;
  real_T (*c2_x)[4];
  real_T *c2_u;
  real_T (*c2_vTK)[759];
  real_T (*c2_mK)[3036];
} SFc2_V3_simInstanceStruct;

#endif                                 /*typedef_SFc2_V3_simInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c2_V3_sim_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_V3_sim_get_check_sum(mxArray *plhs[]);
extern void c2_V3_sim_method_dispatcher(SimStruct *S, int_T method, void *data);

#endif
