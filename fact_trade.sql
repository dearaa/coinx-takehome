{\rtf1\ansi\ansicpg1252\cocoartf2758
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red22\green79\blue199;\red255\green255\blue255;\red24\green25\blue27;
\red0\green0\blue0;\red46\green49\blue51;\red159\green77\blue4;}
{\*\expandedcolortbl;;\cssrgb\c9804\c40392\c82353;\cssrgb\c100000\c100000\c100000;\cssrgb\c12549\c12941\c14118;
\cssrgb\c0\c0\c0;\cssrgb\c23529\c25098\c26275;\cssrgb\c69020\c37647\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 SELECT\cf4 \strokec4  \cb1 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3   \strokec5 rtrade.token_id\strokec4 ,\cb1 \
\cb3   \strokec5 user_id\strokec4 ,\cb1 \
\cb3   \strokec5 token_name\strokec4 ,\cb1 \
\cb3   \strokec5 category\strokec4 ,\cb1 \
\cb3   \strokec5 status\strokec4 ,\cb1 \
\cb3   \strokec5 side\strokec4 ,\cb1 \
\cb3   \cf2 \strokec2 round\cf6 \strokec6 (\cf2 \strokec2 sum\cf6 \strokec6 (\cf4 \strokec5 price_usd\cf6 \strokec6 *\cf4 \strokec5 quantity\cf6 \strokec6 )\cf4 \strokec4 ,\cf7 \strokec7 3\cf6 \strokec6 )\cf4 \strokec4  \strokec5 sum_trade_value\strokec4 ,\cb1 \
\cb3   \cf2 \strokec2 round\cf6 \strokec6 (\cf2 \strokec2 avg\cf6 \strokec6 (\cf4 \strokec5 price_usd\cf6 \strokec6 *\cf4 \strokec5 quantity\cf6 \strokec6 )\cf4 \strokec4 ,\cf7 \strokec7 3\cf6 \strokec6 )\cf4 \strokec4  \strokec5 average_trade_value\strokec4 ,\cb1 \
\cb3   \cf2 \strokec2 count\cf6 \strokec6 (\cf2 \strokec2 distinct\cf4 \strokec4  \strokec5 trade_id\cf6 \strokec6 )\cf4 \strokec4  \strokec5 total_trade\strokec4 ,\cb1 \
\cb3   \cf2 \strokec2 date_trunc\cf6 \strokec6 (\cf4 \strokec5 trade_created_time\strokec4 , \strokec5 month\cf6 \strokec6 )\cf4 \strokec4  \strokec5 month_trade\cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 FROM\cf4 \strokec4  \cb1 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3 \strokec5 `third-pad-476804-p7.coinx.raw_trades`\strokec4  \strokec5 rtrade\cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 left\cf4 \strokec4  \cf2 \strokec2 join\cf4 \strokec4  \cb1 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3 \strokec5 `third-pad-476804-p7.coinx.raw_token`\strokec4  \strokec5 rtoken\cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 on\cf4 \strokec4  \strokec5 rtrade.token_id\strokec4  = \strokec5 rtoken.token_id\cb1 \strokec4 \
\cf2 \cb3 \strokec2 group\cf4 \strokec4  \cf2 \strokec2 by\cf4 \strokec4  \cf7 \strokec7 1\cf4 \strokec4 ,\cf7 \strokec7 2\cf4 \strokec4 ,\cf7 \strokec7 3\cf4 \strokec4 ,\cf7 \strokec7 4\cf4 \strokec4 ,\cf7 \strokec7 5\cf4 \strokec4 ,\cf7 \strokec7 6\cf4 \strokec4 ,\cf7 \strokec7 10\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 order\cf4 \strokec4  \cf2 \strokec2 by\cf4 \strokec4  \cf7 \strokec7 1\cf4 \strokec4 ,\cf7 \strokec7 2\cf4 \strokec4 ,\cf7 \strokec7 3\cf4 \strokec4 ,\cf7 \strokec7 4\cf4 \strokec4 ,\cf7 \strokec7 5\cf4 \strokec4 ,\cf7 \strokec7 6\cf4 \strokec4 ,\cf7 \strokec7 10\cf4 \cb1 \strokec4 \
}