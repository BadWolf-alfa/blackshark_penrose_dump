# $1: audio source
#     main-mic: main mic
#     top-mic: top mic
#     side-mic: side mic
#     headset-mic: headset mic
#     us: ultrasound
# $2: sample rate(Hz)
# $3: sample bit
# $4: channel number
# $5: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-t duration]
# sample usage: capture.sh main-mic 48000 16 2 10

rate=KHZ_192
filename=/data/unknown_mic.wav
sd_filename=/sdcard/unknown_mic.wav

case "$2" in
    "48000" )
        rate=KHZ_48
        ;;
    "96000" )
        rate=KHZ_96
        ;;
    "192000" )
        rate=KHZ_192
        ;;
esac

function enable_main_mic
{
	echo "enabling main mic"
	tinymix 'TX_DEC0 Volume' 84
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ADC0'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 1
	tinymix 'ADC1_MIXER Switch' 1
	tinymix 'ADC1 Volume' 18
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 1
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' $rate
}

function disable_main_mic
{
	echo "disabling main mic"
	tinymix 'TX_DEC0 Volume' 84
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ZERO'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 0
	tinymix 'ADC1_MIXER Switch' 1
	tinymix 'ADC1 Volume' 6
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 0
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' 'KHZ_48'
}

function enable_top_mic
{
	echo "enabling top mic"
	tinymix 'TX_DEC0 Volume' 84
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ADC3'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 1
	tinymix 'ADC4_MIXER Switch' 1
	tinymix 'ADC4 MUX' 'INP5'
	tinymix 'ADC4 Volume' 18
	tinymix 'HDR34 MUX' 'NO_HDR34'
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 1
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' $rate
}

function disable_top_mic
{
	echo "disabling top mic"
	tinymix 'TX_DEC0 Volume' 84
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ZERO'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 0
	tinymix 'ADC4_MIXER Switch' 1
	tinymix 'ADC4 MUX' 'INP5'
	tinymix 'ADC4 Volume' 6
	tinymix 'HDR34 MUX' 'NO_HDR34'
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 0
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' 'KHZ_48'
}

function enable_side_mic
{
	echo "enabling side mic"
	tinymix 'TX_DEC0 Volume' 84
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ADC2'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 1
	tinymix 'ADC3_MIXER Switch' 1
	tinymix 'ADC3 MUX' 'INP4'
	tinymix 'HDR34 MUX' 'NO_HDR34'
	tinymix 'ADC3 Volume' 18
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 1
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' $rate
}

function disable_side_mic
{
	echo "disabling side mic"
	tinymix 'TX_DEC0 Volume' 84
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ZERO'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 0
	tinymix 'ADC3_MIXER Switch' 1
	tinymix 'ADC3 MUX' 'INP4'
	tinymix 'HDR34 MUX' 'NO_HDR34'
	tinymix 'ADC3 Volume' 6
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 0
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' 'KHZ_48'
}

function enable_headset_mic
{
	echo "enabling headset mic"
	tinymix 'TX_DEC0 Volume' 100
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ADC1'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 1
	tinymix 'DEC0_BCS Switch' 1
	tinymix 'ADC2_MIXER Switch' 1
	tinymix 'HDR12 MUX' 'NO_HDR12'
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'ADC2 Volume' 20
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 1
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' $rate

}

function disable_headset_mic
{
	echo "disabling headset mic"
	tinymix 'TX_DEC0 Volume' 84
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ZERO'
	tinymix 'TX_CDC_DMA_TX_3 Channels' 'One'
	tinymix 'TX_AIF1_CAP Mixer DEC0' 0
	tinymix 'DEC0_BCS Switch' 0
	tinymix 'ADC2_MIXER Switch' 0
	tinymix 'HDR12 MUX' 'NO_HDR12'
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'ADC2 Volume' 6
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_3' 0
	tinymix 'TX_CDC_DMA_TX_3 SampleRate' 'KHZ_48'
}

function enable_ultrasound_mic
{
	echo "enable ultrasound mic"
	tinymix 'TX_CDC_DMA_TX_4 Channels' 'One'
	tinymix 'TX_CDC_DMA_TX_4 SampleRate' $rate
	tinymix 'TX_CDC_DMA_TX_4 Format' 'S16_LE'
	tinymix 'TX DEC2 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX2' 'ADC2'
	tinymix 'HDR34 MUX' 'HDR34'
	tinymix 'TX_AIF2_CAP Mixer DEC2' '1'
	tinymix 'ADC3_MIXER Switch' '1'
	tinymix 'ADC3 Volume' '6'
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_4' 1
}

function disable_ultrasound_mic
{
	echo "disable ultrasound mic"
	tinymix 'TX SMIC MUX2' 'ZERO'
	tinymix 'TX_CDC_DMA_TX_4 Channels' 'One'
	tinymix 'TX_AIF2_CAP Mixer DEC2' '0'
	tinymix 'ADC3_MIXER Switch' '0'
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_4' '0'
	tinymix 'TX_CDC_DMA_TX_4 SampleRate' 'KHZ_48'
	tinymix 'TX_CDC_DMA_TX_4 Channels' 'One'
	tinymix 'TX_CDC_DMA_TX_4 Format' 'S16_LE'
	tinymix 'MultiMedia1 Mixer TX_CDC_DMA_TX_4' 0
}


case "$1" in
    "main-mic" )
        enable_main_mic
        filename=/data/main_mic.wav
        sd_filename=/sdcard/main_mic.wav
        ;;
    "top-mic" )
        enable_top_mic
        filename=/data/top_mic.wav
        sd_filename=/sdcard/top_mic.wav
        ;;
    "side-mic" )
        enable_side_mic
        filename=/data/side_mic.wav
        sd_filename=/sdcard/side_mic.wav
        ;;
    "headset-mic" )
        enable_headset_mic
        filename=/data/headset_mic.wav
        sd_filename=/sdcard/headset_mic.wav
        ;;
    "us" )
        enable_ultrasound_mic
        filename=/data/us_mic.wav
        sd_filename=/sdcard/us_mic.wav
        ;;
    *)
        echo "Usage: capture.sh main-mic 48000 16 2 10"
        ;;
esac

if [ -z "$6" ]; then
    period_size=1024
else
    period_size=$6
fi

if [ -z "$7" ]; then
    n_periods=4
else
    n_periods=$7
fi


# start recording
echo "start recording"
tinycap $filename -r $2 -b $3 -c $4 -T $5 -p $period_size -n $n_periods
ret=$?
if [ $ret -ne 0 ]; then
    echo "tinycap done, return $ret"
fi
cp $filename $sd_filename
# tear down
case "$1" in
    "main-mic" )
        disable_main_mic
        ;;
    "top-mic" )
        disable_top_mic
        ;;
    "side-mic" )
        disable_side_mic
        ;;
    "headset-mic" )
        disable_headset_mic
        ;;
    "us" )
        disable_ultrasound_mic
        ;;
esac

