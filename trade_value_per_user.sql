{\rtf1\ansi\ansicpg1252\cocoartf2758
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red24\green25\blue27;\red255\green255\blue255;\red22\green79\blue199;
\red167\green0\blue95;\red0\green0\blue0;\red46\green49\blue51;\red159\green77\blue4;\red24\green112\blue43;
}
{\*\expandedcolortbl;;\cssrgb\c12549\c12941\c14118;\cssrgb\c100000\c100000\c100000;\cssrgb\c9804\c40392\c82353;
\cssrgb\c72157\c2353\c44706;\cssrgb\c0\c0\c0;\cssrgb\c23529\c25098\c26275;\cssrgb\c69020\c37647\c0;\cssrgb\c9412\c50196\c21961;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2   \cf4 \strokec4 SELECT\cf2 \strokec2  \cb1 \
\cb3   \cf5 \cb3 \strokec5 --  token_name,\cf2 \cb1 \strokec2 \
\cb3   \cf5 \cb3 \strokec5 -- category,\cf2 \cb1 \strokec2 \
\cb3   \strokec6 user_id\strokec2 ,\cb1 \
\cb3    \cf4 \strokec4 round\cf7 \strokec7 (\cf4 \strokec4 sum\cf7 \strokec7 (\cf2 \strokec6 sum_trade_value\cf7 \strokec7 )\cf2 \strokec2 ,\cf8 \strokec8 2\cf7 \strokec7 )\cf2 \strokec2  \strokec6 sum_trade_value\strokec2 ,\cb1 \
\cb3    \cf4 \strokec4 sum\cf7 \strokec7 (\cf2 \strokec6 total_trade\cf7 \strokec7 )\cf2 \strokec2  \strokec6 total_trade\cb1 \strokec2 \
\cb3   \cf4 \strokec4 FROM\cf2 \strokec2  \cb1 \
\cb3   \strokec6 `third-pad-476804-p7.coinx.fact_trades`\strokec2  \strokec6 rtrade\cb1 \strokec2 \
\cb3   \cf4 \strokec4 where\cf2 \strokec2  \cb1 \
\cb3     \strokec6 status\strokec2  = \cf9 \cb3 \strokec9 'FILLED'\cf2 \cb1 \strokec2 \
\cb3   \cf5 \cb3 \strokec5 --   and side = 'BUY'\cf2 \cb1 \strokec2 \
\cb3   \cf4 \strokec4 group\cf2 \strokec2  \cf4 \strokec4 by\cf2 \strokec2  \cf8 \strokec8 1\cf2 \cb1 \strokec2 \
\cb3   \cf4 \strokec4 order\cf2 \strokec2  \cf4 \strokec4 by\cf2 \strokec2  \cf8 \strokec8 3\cf2 \strokec2  \cf4 \strokec4 desc\cf2 \cb1 \strokec2 \
\
}