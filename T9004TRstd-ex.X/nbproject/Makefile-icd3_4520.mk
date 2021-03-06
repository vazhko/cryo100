#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-icd3_4520.mk)" "nbproject/Makefile-local-icd3_4520.mk"
include nbproject/Makefile-local-icd3_4520.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=icd3_4520
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../main.c ../isr.c ../conf_bits.c ../sensors.c ../lib/ad7793.c ../lib/eeprom.c ../lib/lcd8.c ../lib/messages.c ../lib/modbus_RTU.c ../lib/slide_filter.c ../lib/sub18.c ../lib/usart.c ../lib/delay.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1472/main.p1 ${OBJECTDIR}/_ext/1472/isr.p1 ${OBJECTDIR}/_ext/1472/conf_bits.p1 ${OBJECTDIR}/_ext/1472/sensors.p1 ${OBJECTDIR}/_ext/1360930230/ad7793.p1 ${OBJECTDIR}/_ext/1360930230/eeprom.p1 ${OBJECTDIR}/_ext/1360930230/lcd8.p1 ${OBJECTDIR}/_ext/1360930230/messages.p1 ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1 ${OBJECTDIR}/_ext/1360930230/slide_filter.p1 ${OBJECTDIR}/_ext/1360930230/sub18.p1 ${OBJECTDIR}/_ext/1360930230/usart.p1 ${OBJECTDIR}/_ext/1360930230/delay.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1472/main.p1.d ${OBJECTDIR}/_ext/1472/isr.p1.d ${OBJECTDIR}/_ext/1472/conf_bits.p1.d ${OBJECTDIR}/_ext/1472/sensors.p1.d ${OBJECTDIR}/_ext/1360930230/ad7793.p1.d ${OBJECTDIR}/_ext/1360930230/eeprom.p1.d ${OBJECTDIR}/_ext/1360930230/lcd8.p1.d ${OBJECTDIR}/_ext/1360930230/messages.p1.d ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1.d ${OBJECTDIR}/_ext/1360930230/slide_filter.p1.d ${OBJECTDIR}/_ext/1360930230/sub18.p1.d ${OBJECTDIR}/_ext/1360930230/usart.p1.d ${OBJECTDIR}/_ext/1360930230/delay.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1472/main.p1 ${OBJECTDIR}/_ext/1472/isr.p1 ${OBJECTDIR}/_ext/1472/conf_bits.p1 ${OBJECTDIR}/_ext/1472/sensors.p1 ${OBJECTDIR}/_ext/1360930230/ad7793.p1 ${OBJECTDIR}/_ext/1360930230/eeprom.p1 ${OBJECTDIR}/_ext/1360930230/lcd8.p1 ${OBJECTDIR}/_ext/1360930230/messages.p1 ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1 ${OBJECTDIR}/_ext/1360930230/slide_filter.p1 ${OBJECTDIR}/_ext/1360930230/sub18.p1 ${OBJECTDIR}/_ext/1360930230/usart.p1 ${OBJECTDIR}/_ext/1360930230/delay.p1

# Source Files
SOURCEFILES=../main.c ../isr.c ../conf_bits.c ../sensors.c ../lib/ad7793.c ../lib/eeprom.c ../lib/lcd8.c ../lib/messages.c ../lib/modbus_RTU.c ../lib/slide_filter.c ../lib/sub18.c ../lib/usart.c ../lib/delay.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-icd3_4520.mk dist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18F4520
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1472/main.p1: ../main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/main.p1  ../main.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/main.d ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/isr.p1: ../isr.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/isr.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/isr.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/isr.p1  ../isr.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/isr.d ${OBJECTDIR}/_ext/1472/isr.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/isr.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/conf_bits.p1: ../conf_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/conf_bits.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/conf_bits.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/conf_bits.p1  ../conf_bits.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/conf_bits.d ${OBJECTDIR}/_ext/1472/conf_bits.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/conf_bits.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/sensors.p1: ../sensors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/sensors.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/sensors.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/sensors.p1  ../sensors.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/sensors.d ${OBJECTDIR}/_ext/1472/sensors.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/sensors.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/ad7793.p1: ../lib/ad7793.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/ad7793.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/ad7793.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/ad7793.p1  ../lib/ad7793.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/ad7793.d ${OBJECTDIR}/_ext/1360930230/ad7793.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/ad7793.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/eeprom.p1: ../lib/eeprom.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/eeprom.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/eeprom.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/eeprom.p1  ../lib/eeprom.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/eeprom.d ${OBJECTDIR}/_ext/1360930230/eeprom.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/eeprom.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/lcd8.p1: ../lib/lcd8.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/lcd8.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/lcd8.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/lcd8.p1  ../lib/lcd8.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/lcd8.d ${OBJECTDIR}/_ext/1360930230/lcd8.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/lcd8.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/messages.p1: ../lib/messages.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/messages.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/messages.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/messages.p1  ../lib/messages.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/messages.d ${OBJECTDIR}/_ext/1360930230/messages.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/messages.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1: ../lib/modbus_RTU.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1  ../lib/modbus_RTU.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.d ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/slide_filter.p1: ../lib/slide_filter.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/slide_filter.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/slide_filter.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/slide_filter.p1  ../lib/slide_filter.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/slide_filter.d ${OBJECTDIR}/_ext/1360930230/slide_filter.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/slide_filter.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/sub18.p1: ../lib/sub18.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/sub18.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/sub18.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/sub18.p1  ../lib/sub18.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/sub18.d ${OBJECTDIR}/_ext/1360930230/sub18.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/sub18.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/usart.p1: ../lib/usart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/usart.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/usart.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/usart.p1  ../lib/usart.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/usart.d ${OBJECTDIR}/_ext/1360930230/usart.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/usart.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/delay.p1: ../lib/delay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/delay.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/delay.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/delay.p1  ../lib/delay.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/delay.d ${OBJECTDIR}/_ext/1360930230/delay.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/delay.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
else
${OBJECTDIR}/_ext/1472/main.p1: ../main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/main.p1  ../main.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/main.d ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/isr.p1: ../isr.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/isr.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/isr.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/isr.p1  ../isr.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/isr.d ${OBJECTDIR}/_ext/1472/isr.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/isr.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/conf_bits.p1: ../conf_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/conf_bits.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/conf_bits.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/conf_bits.p1  ../conf_bits.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/conf_bits.d ${OBJECTDIR}/_ext/1472/conf_bits.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/conf_bits.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/sensors.p1: ../sensors.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/sensors.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/sensors.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1472/sensors.p1  ../sensors.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/sensors.d ${OBJECTDIR}/_ext/1472/sensors.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/sensors.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/ad7793.p1: ../lib/ad7793.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/ad7793.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/ad7793.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/ad7793.p1  ../lib/ad7793.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/ad7793.d ${OBJECTDIR}/_ext/1360930230/ad7793.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/ad7793.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/eeprom.p1: ../lib/eeprom.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/eeprom.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/eeprom.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/eeprom.p1  ../lib/eeprom.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/eeprom.d ${OBJECTDIR}/_ext/1360930230/eeprom.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/eeprom.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/lcd8.p1: ../lib/lcd8.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/lcd8.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/lcd8.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/lcd8.p1  ../lib/lcd8.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/lcd8.d ${OBJECTDIR}/_ext/1360930230/lcd8.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/lcd8.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/messages.p1: ../lib/messages.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/messages.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/messages.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/messages.p1  ../lib/messages.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/messages.d ${OBJECTDIR}/_ext/1360930230/messages.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/messages.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1: ../lib/modbus_RTU.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1  ../lib/modbus_RTU.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.d ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/modbus_RTU.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/slide_filter.p1: ../lib/slide_filter.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/slide_filter.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/slide_filter.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/slide_filter.p1  ../lib/slide_filter.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/slide_filter.d ${OBJECTDIR}/_ext/1360930230/slide_filter.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/slide_filter.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/sub18.p1: ../lib/sub18.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/sub18.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/sub18.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/sub18.p1  ../lib/sub18.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/sub18.d ${OBJECTDIR}/_ext/1360930230/sub18.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/sub18.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/usart.p1: ../lib/usart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/usart.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/usart.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/usart.p1  ../lib/usart.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/usart.d ${OBJECTDIR}/_ext/1360930230/usart.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/usart.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1360930230/delay.p1: ../lib/delay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360930230" 
	@${RM} ${OBJECTDIR}/_ext/1360930230/delay.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1360930230/delay.p1 
	${MP_CC} --pass1 $(MP_EXTRA_CC_PRE) --chip=$(MP_PROCESSOR_OPTION) -Q -G  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib $(COMPARISON_BUILD)  --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    -o${OBJECTDIR}/_ext/1360930230/delay.p1  ../lib/delay.c 
	@-${MV} ${OBJECTDIR}/_ext/1360930230/delay.d ${OBJECTDIR}/_ext/1360930230/delay.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1360930230/delay.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) --chip=$(MP_PROCESSOR_OPTION) -G -mdist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.map  -D__DEBUG=1 --debugger=icd3  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"     --rom=default,-7dc0-7fff --ram=default,-5f4-5ff,-f9c-f9c,-fd4-fd4,-fdb-fdf,-fe3-fe7,-feb-fef,-ffd-fff  $(COMPARISON_BUILD)  -odist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	@${RM} dist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.hex 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) --chip=$(MP_PROCESSOR_OPTION) -G -mdist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.map  --double=32 --float=24 --emi=wordwrite --opt=default,+asm,+asmfile,-speed,+space,+debug --addrqual=ignore --mode=pro -DUSE_RS485 -DUSE_SLIDE_FILTER -P -N255 -I".." -I"../lib/" --warn=0 --asmlist -DXPRJ_icd3_4520=$(CND_CONF)  --summary=default,-psect,-class,+mem,-hex,-file --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,+plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"     $(COMPARISON_BUILD)  -odist/${CND_CONF}/${IMAGE_TYPE}/T9004TRstd-ex.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/icd3_4520
	${RM} -r dist/icd3_4520

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
