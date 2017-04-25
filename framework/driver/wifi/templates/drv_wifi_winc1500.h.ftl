/*** Wi-Fi Driver Configuration ***/
<#if CONFIG_DRV_WIFI_INTERRUPT_SYSTEM_SERVICE == "External Interrupt">
 <#if CONFIG_EXT_INT_INST_IDX0_USED_BY_DRV_WIFI>
#define WINC1500_INT_SOURCE ${CONFIG_EXT_INT_INTERRUPT_SOURCE_IDX0}
#define WINC1500_INT_VECTOR ${CONFIG_EXT_INT_INTERRUPT_VECTOR_IDX0}
 <#elseif CONFIG_EXT_INT_INST_IDX1_USED_BY_DRV_WIFI>
#define WINC1500_INT_SOURCE ${CONFIG_EXT_INT_INTERRUPT_SOURCE_IDX1}
#define WINC1500_INT_VECTOR ${CONFIG_EXT_INT_INTERRUPT_VECTOR_IDX1}
 <#elseif CONFIG_EXT_INT_INST_IDX2_USED_BY_DRV_WIFI>
#define WINC1500_INT_SOURCE ${CONFIG_EXT_INT_INTERRUPT_SOURCE_IDX2}
#define WINC1500_INT_VECTOR ${CONFIG_EXT_INT_INTERRUPT_VECTOR_IDX2}
 <#elseif CONFIG_EXT_INT_INST_IDX3_USED_BY_DRV_WIFI>
#define WINC1500_INT_SOURCE ${CONFIG_EXT_INT_INTERRUPT_SOURCE_IDX3}
#define WINC1500_INT_VECTOR ${CONFIG_EXT_INT_INTERRUPT_VECTOR_IDX3}
 <#elseif CONFIG_EXT_INT_INST_IDX4_USED_BY_DRV_WIFI>
#define WINC1500_INT_SOURCE ${CONFIG_EXT_INT_INTERRUPT_SOURCE_IDX4}
#define WINC1500_INT_VECTOR ${CONFIG_EXT_INT_INTERRUPT_VECTOR_IDX4}
 <#else>
#error "Please select an external interrupt instance for Wi-Fi driver."
 </#if><#-- Wi-Fi Driver External Interrupt Instance -->
<#elseif CONFIG_DRV_WIFI_INTERRUPT_SYSTEM_SERVICE == "Change Notification">
#define WINC1500_INT_SOURCE INT_SOURCE_CHANGE_NOTICE
#define WINC1500_INT_VECTOR INT_VECTOR_CN
</#if><#-- CONFIG_DRV_WIFI_INTERRUPT_SYSTEM_SERVICE -->

<#if CONFIG_DRV_WIFI_SPI_INSTANCE_INDEX == '0'>
#define WDRV_SPI_INDEX 0
#define WDRV_SPI_INSTANCE sysObj.spiObjectIdx0
<#elseif CONFIG_DRV_WIFI_SPI_INSTANCE_INDEX == '1'>
#define WDRV_SPI_INDEX 1
#define WDRV_SPI_INSTANCE sysObj.spiObjectIdx1
<#elseif CONFIG_DRV_WIFI_SPI_INSTANCE_INDEX == '2'>
#define WDRV_SPI_INDEX 2
#define WDRV_SPI_INSTANCE sysObj.spiObjectIdx2
<#elseif CONFIG_DRV_WIFI_SPI_INSTANCE_INDEX == '3'>
#define WDRV_SPI_INDEX 3
#define WDRV_SPI_INSTANCE sysObj.spiObjectIdx3
<#elseif CONFIG_DRV_WIFI_SPI_INSTANCE_INDEX == '4'>
#define WDRV_SPI_INDEX 4
#define WDRV_SPI_INSTANCE sysObj.spiObjectIdx4
<#elseif CONFIG_DRV_WIFI_SPI_INSTANCE_INDEX == '5'>
#define WDRV_SPI_INDEX 5
#define WDRV_SPI_INSTANCE sysObj.spiObjectIdx5
</#if><#-- CONFIG_DRV_WIFI_SPI_INSTANCE_INDEX -->
<#if CONFIG_DRV_WIFI_USE_SPI_DMA>

#define WDRV_USE_SPI_DMA
</#if><#-- CONFIG_DRV_WIFI_USE_SPI_DMA -->
<#if CONFIG_DRV_WIFI_STORE_CONFIG_IN_NVM>

#define WDRV_NVM_SPACE_ENABLE
#define WDRV_NVM_SPACE_ADDR (${CONFIG_DRV_WIFI_NVM_START_ADDRESS} * 1024)
</#if><#-- CONFIG_DRV_WIFI_STORE_CONFIG_IN_NVM -->
<#if CONFIG_WINC1500_FW_UPDATE_OVER_SERIAL>

#define FW_UPDATE_OVER_SERIAL_ENABLED
</#if><#-- CONFIG_WINC1500_FW_UPDATE_OVER_SERIAL -->

<#if CONFIG_BSP_PIC32MX795_PIM_E16>
#define WDRV_BOARD_TYPE WDRV_BD_TYPE_EXP16
<#elseif CONFIG_BSP_PIC32MZ_EC_SK || CONFIG_BSP_PIC32MZ_EF_SK>
#define WDRV_BOARD_TYPE WDRV_BD_TYPE_MZ_ESK
<#else>
#define WDRV_BOARD_TYPE WDRV_BD_TYPE_CUSTOM
</#if><#-- CONFIG_BSP -->

#define WDRV_EXT_RTOS_TASK_SIZE ${CONFIG_WINC1500_RTOS_TASK_SIZE}u
#define WDRV_EXT_RTOS_TASK_PRIORITY ${CONFIG_WINC1500_RTOS_TASK_PRIORITY}u

// I/O mappings for general control pins, including CHIP_EN, IRQN, RESET_N and SPI_SSN.
#define WDRV_CHIP_EN_PORT_CHANNEL   PORT_CHANNEL_${CONFIG_WINC1500_CHIP_EN_PORT_CHANNEL}
#define WDRV_CHIP_EN_BIT_POS        ${CONFIG_WINC1500_CHIP_EN_BIT_POS}

#define WDRV_IRQN_PORT_CHANNEL      PORT_CHANNEL_${CONFIG_WINC1500_IRQ_PORT_CHANNEL}
#define WDRV_IRQN_BIT_POS           ${CONFIG_WINC1500_IRQ_BIT_POS}

#define WDRV_RESET_N_PORT_CHANNEL   PORT_CHANNEL_${CONFIG_WINC1500_RESET_PORT_CHANNEL}
#define WDRV_RESET_N_BIT_POS        ${CONFIG_WINC1500_RESET_BIT_POS}

#define WDRV_SPI_SSN_PORT_CHANNEL   PORT_CHANNEL_${CONFIG_WINC1500_SPI_SS_PORT_CHANNEL}
#define WDRV_SPI_SSN_BIT_POS        ${CONFIG_WINC1500_SPI_SS_BIT_POS}

<#if CONFIG_WINC1500_NETWORK_TYPE == "Infrastructure">
#define WDRV_DEFAULT_NETWORK_TYPE WDRV_NETWORK_TYPE_INFRASTRUCTURE
#define WDRV_DEFAULT_CHANNEL 6
<#if CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE == "WPS Push Button">
#define WDRV_DEFAULT_SSID ""
<#else>
#define WDRV_DEFAULT_SSID "${CONFIG_WINC1500_SSID}"
</#if>

<#if CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE == "Open">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_OPEN
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE == "WEP-40 (64-bit)">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WEP_40
#define WDRV_DEFAULT_WEP_KEYS_40 "${CONFIG_WINC1500_WEP_KEY_40}" // customized WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE == "WEP-104 (128-bit)">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WEP_104
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "${CONFIG_WINC1500_WEP_KEY_104}" // customized WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE == "WPA-PSK/WPA2-PSK Auto">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WPA_AUTO_WITH_PASS_PHRASE
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "${CONFIG_WINC1500_WPA_PASS_PHRASE}" // customized WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE == "WPS Push Button">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WPS_PUSH_BUTTON
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE == "WPS PIN">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WPS_PIN
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "${CONFIG_WINC1500_WPS_PIN}" // customized WPS PIN
</#if><#-- CONFIG_WINC1500_INFRASTRUCTURE_SECURITY_MODE -->
<#elseif CONFIG_WINC1500_NETWORK_TYPE == "Soft AP" >
#define WDRV_DEFAULT_NETWORK_TYPE WDRV_NETWORK_TYPE_SOFT_AP
#define WDRV_DEFAULT_CHANNEL ${CONFIG_WINC1500_SOFTAP_OPERATING_CHANNEL}
#define WDRV_DEFAULT_SSID "${CONFIG_WINC1500_SSID}"

<#if CONFIG_WINC1500_SOFTAP_SECURITY_MODE == "Open">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_OPEN
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_SOFTAP_SECURITY_MODE == "WEP-40 (64-bit)">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WEP_40
#define WDRV_DEFAULT_WEP_KEYS_40 "${CONFIG_WINC1500_WEP_KEY_40}" // customized WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_SOFTAP_SECURITY_MODE == "WEP-104 (128-bit)">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WEP_104
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "${CONFIG_WINC1500_WEP_KEY_104}" // customized WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "Microchip 802.11 Secret PSK Password" // default WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
<#elseif CONFIG_WINC1500_SOFTAP_SECURITY_MODE == "WPA-PSK/WPA2-PSK Auto">
#define WDRV_DEFAULT_SECURITY_MODE WDRV_SECURITY_WPA_AUTO_WITH_PASS_PHRASE
#define WDRV_DEFAULT_WEP_KEYS_40 "5AFB6C8E77" // default WEP40 key
#define WDRV_DEFAULT_WEP_KEYS_104 "90E96780C739409DA50034FCAA" // default WEP104 key
#define WDRV_DEFAULT_PSK_PHRASE "${CONFIG_WINC1500_WPA_PASS_PHRASE}" // customized WPA-PSK or WPA2-PSK passphrase
#define WDRV_DEFAULT_WPS_PIN "12390212" // default WPS PIN
</#if><#-- CONFIG_WINC1500_SOFTAP_SECURITY_MODE -->
</#if><#-- CONFIG_WINC1500_NETWORK_TYPE -->

#define WDRV_DEFAULT_POWER_SAVE WDRV_FUNC_DISABLED

#define PIN_MODE_PER_PORT_SELECT

#define WDRV_ASSERT(condition, msg) WDRV_Assert(condition, msg, __FILE__, __LINE__)
<#--
/*******************************************************************************
 End of File
 */
-->