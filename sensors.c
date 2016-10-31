#include "sensors.h"


const char s_name_pt100_375[] = " PT100(375) @C";
const char s_name_pt100_385[] = " PT100(385) @C";
const char s_name_pt1000_375[] = " PT1000(375) @C";
const char s_name_pt1000_385[] = " PT1000(385) @C";
const char s_name_R2925[] = " 0..2925.0 Ohm";
const char s_name_R365[] = " 0..365.00 Ohm";

const char s_unit_gc[] = "@C";
const char s_unit_om[] = "^";
const char s_unit_no[] = "^ ";

const double p_sens_pt100_375[] = {
	-250.7100067,
	2.39140004,
	1.16E-03
};

const double p_sens_pt100_385[] = {
	-242.99544,
	2.30582,
	0.00123

};

const double p_sens_pt1000_375[] = {
	-250.7100067,
	0.239140004,
	1.16E-05
};

const double p_sens_pt1000_385[] = {
	-242.99544,
	0.230582,
	0.0000123
};

const double p_sens_r[] = {
	0.0,
	1.0
};

const Sensors sensors[] = {
	{
		{s_name_R2925},
		{s_unit_no},
		{p_sens_r},
		{2},
		{2}, // gain
		{1}, // 0.0
		{0.0},
		{2925.0}
	},
	{
		{s_name_R365},
		{s_unit_om},
		{p_sens_r},
		{2},
		{16}, // gain
		{2}, // 0.00
		{0.0},
		{370.0}

	},
	{
		{s_name_pt1000_375},
		{s_unit_gc},
		{p_sens_pt1000_375},
		{3},
		{2}, // gain
		{1}, // 0.0
		{-200.0},
		{600.0}
	},
	{
		{s_name_pt1000_385},
		{s_unit_gc},
		{p_sens_pt1000_385},
		{3},
		{2}, // gain
		{1}, // 0.0
		{-200.0},
		{600.0}
	},
	{
		{s_name_pt100_375},
		{s_unit_gc},
		{p_sens_pt100_375},
		{3},
		{16}, // gain
		{1}, // 0.0
		{-200.0},
		{600.0}
	},
	{
		{s_name_pt100_385},
		{s_unit_gc},
		{p_sens_pt100_385},
		{3},
		{16}, // gain
		{1}, // 0.0
		{-200.0},
		{600.0}
	}
};


