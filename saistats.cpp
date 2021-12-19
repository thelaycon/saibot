
#include <iostream>
#include <string>
#include <iomanip>

#include <boost/math/distributions/fisher_f.hpp>
using boost::math::fisher_f;


extern "C" {

#include "lua54/lua.h"
#include "lua54/lualib.h"
#include "lua54/lauxlib.h"
}

#define DIST_MODULE "1.0"
extern "C" {
	static int fisher_critical(lua_State *L) {
	
	int n = lua_gettop(L);
	double df2 = (double)lua_tonumber(L, 3);
	double df1 = (double)lua_tonumber(L, 2);
	double a = (double)lua_tonumber(L, 1);

	if (n != 3) {
		return 1;
	} else if (n == 3) {
		fisher_f dist(df1, df2);
		double ucv = quantile(complement(dist, a));
		lua_pushnumber(L, ucv);
	}


	return 1;
   
}
}



static const struct luaL_Reg Functions[] =
    {
        { "f", fisher_critical },
        { NULL, NULL }
    };

extern "C" int luaopen_saistats(lua_State *L)
    {
    lua_newtable(L); /* this is the module table */

    /* Set mymodule._VERSION to a string containing the module's version */
    lua_pushstring(L, "DistModule " DIST_MODULE);
    lua_setfield(L, -2, "_VERSION");

    /* add the functions listed in the Functions struct */
    luaL_setfuncs(L, Functions, 0);
    return 1;
    }

