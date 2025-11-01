{\rtf1\ansi\ansicpg1252\cocoartf2758
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red24\green25\blue27;\red255\green255\blue255;\red22\green79\blue199;
\red0\green0\blue0;\red46\green49\blue51;\red159\green77\blue4;}
{\*\expandedcolortbl;;\cssrgb\c12549\c12941\c14118;\cssrgb\c100000\c100000\c100000;\cssrgb\c9804\c40392\c82353;
\cssrgb\c0\c0\c0;\cssrgb\c23529\c25098\c26275;\cssrgb\c69020\c37647\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2   \cf4 \strokec4 SELECT\cf2 \strokec2  \cb1 \
\cb3     \strokec5 rp2p.token_id\strokec2 ,\cb1 \
\cb3     \strokec5 token_name\strokec2 ,\cb1 \
\cb3     \strokec5 category\strokec2 , \cb1 \
\cb3     \strokec5 status\strokec2 ,\cb1 \
\cb3     \strokec5 sender_id\strokec2 ,\cb1 \
\cb3     \strokec5 receiver_id\strokec2 ,\cb1 \
\cb3     \cf4 \strokec4 round\cf6 \strokec6 (\cf4 \strokec4 sum\cf6 \strokec6 (\cf2 \strokec5 amount\cf6 \strokec6 )\cf2 \strokec2 ,\cf7 \strokec7 3\cf6 \strokec6 )\cf2 \strokec2  \strokec5 sum_p2p_value\strokec2 ,\cb1 \
\cb3     \cf4 \strokec4 round\cf6 \strokec6 (\cf4 \strokec4 avg\cf6 \strokec6 (\cf2 \strokec5 amount\cf6 \strokec6 )\cf2 \strokec2 ,\cf7 \strokec7 3\cf6 \strokec6 )\cf2 \strokec2  \strokec5 average_p2p_value\strokec2 ,\cb1 \
\cb3     \cf4 \strokec4 count\cf6 \strokec6 (\cf4 \strokec4 distinct\cf2 \strokec2  \strokec5 transfer_id\cf6 \strokec6 )\cf2 \strokec2  \strokec5 total_transfer\strokec2 ,\cb1 \
\cb3     \cf4 \strokec4 date_trunc\cf6 \strokec6 (\cf2 \strokec5 transfer_created_time\strokec2 , \strokec5 month\cf6 \strokec6 )\cf2 \strokec2  \strokec5 month_transfer\cb1 \strokec2 \
\cb3   \cf4 \strokec4 FROM\cf2 \strokec2  \cb1 \
\cb3   \strokec5 `third-pad-476804-p7.coinx.raw_p2p_transfers`\strokec2  \strokec5 rp2p\cb1 \strokec2 \
\cb3   \cf4 \strokec4 left\cf2 \strokec2  \cf4 \strokec4 join\cf2 \strokec2  \cb1 \
\cb3   \strokec5 `third-pad-476804-p7.coinx.raw_token`\strokec2  \strokec5 rtoken\cb1 \strokec2 \
\cb3   \cf4 \strokec4 on\cf2 \strokec2  \strokec5 rp2p.token_id\strokec2  = \strokec5 rtoken.token_id\cb1 \strokec2 \
\cb3   \cf4 \strokec4 group\cf2 \strokec2  \cf4 \strokec4 by\cf2 \strokec2  \cf7 \strokec7 1\cf2 \strokec2 ,\cf7 \strokec7 2\cf2 \strokec2 ,\cf7 \strokec7 3\cf2 \strokec2 ,\cf7 \strokec7 4\cf2 \strokec2 ,\cf7 \strokec7 5\cf2 \strokec2 ,\cf7 \strokec7 6\cf2 \strokec2 ,\cf7 \strokec7 10\cf2 \cb1 \strokec2 \
\cb3   \cf4 \strokec4 order\cf2 \strokec2  \cf4 \strokec4 by\cf2 \strokec2  \cf7 \strokec7 1\cf2 \strokec2 ,\cf7 \strokec7 2\cf2 \strokec2 ,\cf7 \strokec7 3\cf2 \strokec2 ,\cf7 \strokec7 4\cf2 \strokec2 ,\cf7 \strokec7 5\cf2 \strokec2 ,\cf7 \strokec7 6\cf2 \strokec2 ,\cf7 \strokec7 10\cf2 \cb1 \strokec2 \
}