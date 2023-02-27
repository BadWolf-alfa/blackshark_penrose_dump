set -x
# $1: device for output
#     spk: stereo speaker
#     top-spk: top speaker
#     bot-spk: bottom speaker
#     rcv: receiver
#     spk_hp: speaker high power
#     top-spk_hp: top speaker high power
#     bot-spk_hp: bottom speaker high power
#     rcv_hp: headset
#     us: ultrasound

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk
# rcv.wav:-4.5dbfs   spk: -4.8dbfs  ultra: -4.5dbfs  spk_hp:-1.8dbfs

function enable_receiver
{
    echo "enabling receiver"
    tinymix 'RX_EAR Mode' 'ON'
    tinymix 'RX_MACRO RX0 MUX' 'AIF1_PB'
    tinymix 'RX_CDC_DMA_RX_0 Channels' 'One'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'EAR_RDAC Switch' 1
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'EAR PA Gain' 'G_6_DB'
    tinymix 'RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1' 1
}

function disable_receiver
{
    echo "disabling receiver"
    tinymix 'RX_EAR Mode' 'OFF'
    tinymix 'RX_MACRO RX0 MUX' 'ZERO'
    tinymix 'RX_CDC_DMA_RX_0 Channels' 'One'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'EAR_RDAC Switch' 0
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'EAR PA Gain' 'G_6_DB'
    tinymix 'RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1' 0
}

function enable_speaker
{
    echo "enabling speaker"
    tinymix 'TERT_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'TERT_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'TERT_MI2S_RX Channels' 'Two'
    tinymix 'TERT_MI2S_RX Format' 'S24_LE'
    tinymix 'PCM Source' 'ASP'
    tinymix 'RCV PCM Source' 'ASP'
    tinymix 'AMP PCM Gain' 18
    tinymix 'RCV AMP PCM Gain' 18
    tinymix 'DRE DRE Switch' 1
    tinymix 'RCV DRE DRE Switch' 1
    tinymix 'DSP RX1 Source' 'ASPRX1'
    tinymix 'DSP RX2 Source' 'ASPRX1'
    tinymix 'ASPRX1 Slot Position' 1
    tinymix 'ASPRX2 Slot Position' 4
    tinymix 'RCV DSP RX1 Source' 'ASPRX1'
    tinymix 'RCV DSP RX2 Source' 'ASPRX2'
    tinymix 'RCV ASPRX1 Slot Position' 0
    tinymix 'RCV ASPRX2 Slot Position' 2
    tinymix 'ASP TX1 Source' 'DSPTX1'
    tinymix 'ASP TX2 Source' 'Zero'
    tinymix 'RCV ASP TX1 Source' 'Zero'
    tinymix 'RCV ASP TX2 Source' 'DSPTX1'

    sleep 1
}

function disable_speaker
{
    echo "disabling speaker"
    tinymix 'Cirrus SP Usecase' 'Music'
    tinymix 'PCM Source' 'None'
    tinymix 'RCV PCM Source' 'None'
    tinymix 'AMP PCM Gain' 18
    tinymix 'RCV AMP PCM Gain' 18
    tinymix 'TERT_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'TERT_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'TERT_MI2S_RX Channels' 'Two'
    tinymix 'TERT_MI2S_RX Format' 'S24_LE'
    tinymix 'DRE DRE Switch' 0
    tinymix 'RCV DRE DRE Switch' 0
    tinymix 'DSP RX1 Source' 'Zero'
    tinymix 'DSP RX2 Source' 'Zero'
    tinymix 'RCV DSP RX1 Source' 'Zero'
    tinymix 'RCV DSP RX2 Source' 'Zero'
    tinymix 'ASP TX1 Source' 'Zero'
    tinymix 'ASP TX2 Source' 'Zero'
    tinymix 'RCV ASP TX1 Source' 'Zero'
    tinymix 'RCV ASP TX2 Source' 'Zero'
}

function enable_speaker_top
{
    echo "enabling speaker top"
    tinymix 'TERT_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'TERT_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'TERT_MI2S_RX Channels' 'One'
    tinymix 'TERT_MI2S_RX Format' 'S24_LE'
    tinymix 'PCM Source' 'None'
    tinymix 'RCV PCM Source' 'ASP'
    tinymix 'RCV AMP PCM Gain' 18
    tinymix 'RCV DRE DRE Switch' 1
    tinymix 'RCV ASP TX1 Source' 'Zero'
    tinymix 'RCV ASP TX2 Source' 'DSPTX1'
    tinymix 'RCV DSP RX1 Source' 'ASPRX1'
    tinymix 'RCV DSP RX2 Source' 'ASPRX2'
    tinymix 'RCV ASPRX1 Slot Position' 0
    tinymix 'RCV ASPRX2 Slot Position' 2

    sleep 1
}

function disable_speaker_top
{
    echo "disabling speaker top"
    tinymix 'Cirrus SP Usecase' 'Music'
    tinymix 'PCM Source' 'None'
    tinymix 'RCV PCM Source' 'None'
    tinymix 'RCV AMP PCM Gain' 18
    tinymix 'TERT_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'TERT_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'TERT_MI2S_RX Channels' 'Two'
    tinymix 'TERT_MI2S_RX Format' 'S24_LE'
    tinymix 'RCV DRE DRE Switch' 0
    tinymix 'RCV ASP TX1 Source' 'Zero'
    tinymix 'RCV ASP TX2 Source' 'Zero'
    tinymix 'RCV DSP RX1 Source' 'Zero'
    tinymix 'RCV DSP RX2 Source' 'Zero'
}

function enable_speaker_bot
{
    echo "enabling speaker bottom"
    tinymix 'TERT_MI2S_RX Audio Mixer MultiMedia1' 1
    tinymix 'TERT_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'TERT_MI2S_RX Channels' 'Two'
    tinymix 'TERT_MI2S_RX Format' 'S24_LE'
    tinymix 'PCM Source' 'ASP'
    tinymix 'RCV PCM Source' 'None'
    tinymix 'AMP PCM Gain' 18
    tinymix 'DRE DRE Switch' 1
    tinymix 'DSP RX1 Source' 'ASPRX1'
    tinymix 'DSP RX2 Source' 'ASPRX1'
    tinymix 'ASPRX1 Slot Position' 1
    tinymix 'ASPRX2 Slot Position' 4
    tinymix 'ASP TX1 Source' 'DSPTX1'
    tinymix 'ASP TX2 Source' 'Zero'

    sleep 1
}

function disable_speaker_bot
{
    echo "disabling speaker bottom"
    tinymix 'Cirrus SP Usecase' 'Music'
    tinymix 'PCM Source' 'None'
    tinymix 'RCV PCM Source' 'None'
    tinymix 'AMP PCM Gain' 18
    tinymix 'TERT_MI2S_RX Audio Mixer MultiMedia1' 0
    tinymix 'TERT_MI2S_RX SampleRate' 'KHZ_48'
    tinymix 'TERT_MI2S_RX Channels' 'Two'
    tinymix 'TERT_MI2S_RX Format' 'S24_LE'
    tinymix 'DRE DRE Switch' 0
    tinymix 'DSP RX1 Source' 'Zero'
    tinymix 'DSP RX2 Source' 'Zero'
    tinymix 'ASP TX1 Source' 'Zero'
    tinymix 'ASP TX2 Source' 'Zero'
}

function enable_headset_left
{
    echo "enabling headset left"
    tinymix 'RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1' 1
    tinymix 'RX_MACRO RX0 MUX' 'AIF1_PB'
    tinymix 'RX_MACRO RX1 MUX' 'AIF1_PB'
    tinymix 'RX_CDC_DMA_RX_0 Channels' 'Two'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'RX INT1_1 MIX1 INP0' 'RX1'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX_HPH_PWR_MODE' 'LOHIFI'
    tinymix 'RX HPH Mode' 'CLS_H_LOHIFI'
    tinymix 'RX_COMP1 Switch' 1
    tinymix 'RX_COMP2 Switch' 1
    tinymix 'HPHL_COMP Switch' 1
    tinymix 'HPHR_COMP Switch' 1
    tinymix 'HPHL_RDAC Switch' 1
    tinymix 'HPHR_RDAC Switch' 1
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 100
    tinymix 'RX_RX1 Digital Volume' 0
}

function disable_headset_left
{
    echo "disabling headset left"
    tinymix 'RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1' 0
    tinymix 'RX_MACRO RX0 MUX' 'ZERO'
    tinymix 'RX_MACRO RX1 MUX' 'ZERO'
    tinymix 'RX_CDC_DMA_RX_0 Channels' 'One'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT1_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX_COMP1 Switch' 0
    tinymix 'RX_COMP2 Switch' 0
    tinymix 'HPHL_COMP Switch' 0
    tinymix 'HPHR_COMP Switch' 0
    tinymix 'HPHL_RDAC Switch' 0
    tinymix 'HPHR_RDAC Switch' 0
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 84
    tinymix 'RX_RX1 Digital Volume' 84
}

function enable_headset_right
{
    echo "enabling headset right"
    tinymix 'RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1' 1
    tinymix 'RX_MACRO RX0 MUX' 'AIF1_PB'
    tinymix 'RX_MACRO RX1 MUX' 'AIF1_PB'
    tinymix 'RX_CDC_DMA_RX_0 Channels' 'Two'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'RX INT1_1 MIX1 INP0' 'RX1'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX_HPH_PWR_MODE' 'LOHIFI'
    tinymix 'RX HPH Mode' 'CLS_H_LOHIFI'
    tinymix 'RX_COMP1 Switch' 1
    tinymix 'RX_COMP2 Switch' 1
    tinymix 'HPHL_COMP Switch' 1
    tinymix 'HPHR_COMP Switch' 1
    tinymix 'HPHL_RDAC Switch' 1
    tinymix 'HPHR_RDAC Switch' 1
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 0
    tinymix 'RX_RX1 Digital Volume' 100
}

function disable_headset_right
{
    echo "disabling headset right"
    tinymix 'RX_CDC_DMA_RX_0 Audio Mixer MultiMedia1' 0
    tinymix 'RX_MACRO RX0 MUX' 'ZERO'
    tinymix 'RX_MACRO RX1 MUX' 'ZERO'
    tinymix 'RX_CDC_DMA_RX_0 Channels' 'One'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT1_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX_COMP1 Switch' 0
    tinymix 'RX_COMP2 Switch' 0
    tinymix 'HPHL_COMP Switch' 0
    tinymix 'HPHR_COMP Switch' 0
    tinymix 'HPHL_RDAC Switch' 0
    tinymix 'HPHR_RDAC Switch' 0
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 84
    tinymix 'RX_RX1 Digital Volume' 84
}

function enable_ultrasound
{
    echo "enable ultrasound"
    tinymix 'RX_CDC_DMA_RX_1 SampleRate' 'KHZ_96'
    tinymix 'RX_MACRO RX2 MUX' 'AIF2_PB'
    tinymix 'RX_CDC_DMA_RX_1 Channels' 'One'
    tinymix 'RX INT0_2 MUX' 'RX2'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX_CDC_DMA_RX_1 Audio Mixer MultiMedia1' 1
    tinymix 'EAR_RDAC Switch' 1
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'EAR PA Gain' 'G_6_DB'
    tinymix 'RX_EAR Mode' 'ON'
}

function disable_ultrasound
{
    echo "disable ultrasound"
    tinymix 'RX_CDC_DMA_RX_1 SampleRate' 'KHZ_48'
    tinymix 'RX_MACRO RX2 MUX' 'ZERO'
    tinymix 'RX_CDC_DMA_RX_1 Channels' 'One'
    tinymix 'RX INT0_2 MUX' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX_CDC_DMA_RX_1 Audio Mixer MultiMedia1' 0
    tinymix 'EAR_RDAC Switch' 0
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'RX_EAR Mode' 'OFF'
}

if [ "$1" = "spk" ]; then
    enable_speaker
    filename=/vendor/etc/spk.wav
elif [ "$1" = "top-spk" ]; then
    enable_speaker_top
    filename=/vendor/etc/spk.wav
elif [ "$1" = "bot-spk" ]; then
    enable_speaker_bot
    filename=/vendor/etc/spk.wav
elif [ "$1" = "rcv" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "spk_hp" ]; then
    enable_speaker
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "top-spk_hp" ]; then
    enable_speaker_top
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "bot-spk_hp" ]; then
    enable_speaker_bot
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "rcv_hp" ]; then
    enable_headset
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "us" ]; then
    enable_ultrasound
    filename=/vendor/etc/ultrasound.wav
elif [ "$1" = "main-mic" ]; then
    enable_speaker
    filename=/data/main_mic.wav
elif [ "$1" = "top-mic" ]; then
    enable_speaker
    filename=/data/top_mic.wav
elif [ "$1" = "side-mic" ]; then
    enable_speaker
    filename=/data/side_mic.wav
elif [ "$1" = "headset-left" ]; then
    enable_headset_left
    filename=/data/headset_mic.wav
elif [ "$1" = "headset-right" ]; then
    enable_headset_right
    filename=/data/headset_mic.wav
else
    echo "Usage: playback.sh device; device: spk or rcv or spk_hp or us"
fi

echo "start playing"
tinyplay $filename

if [ "$1" = "spk" ]; then
    disable_speaker
elif [ "$1" = "top-spk" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv" ]; then
    disable_receiver
elif [ "$1" = "spk_hp" ]; then
    disable_speaker
elif [ "$1" = "top-spk_hp" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk_hp" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv_hp" ]; then
    disable_headset
elif [ "$1" = "us" ]; then
    disable_ultrasound
elif [ "$1" = "main-mic" ]; then
    disable_speaker
elif [ "$1" = "top-mic" ]; then
    disable_speaker
elif [ "$1" = "side-mic" ]; then
    disable_speaker
elif [ "$1" = "headset-left" ]; then
    disable_headset_left
elif [ "$1" = "headset-right" ]; then
    disable_headset_right
fi

exit 0
