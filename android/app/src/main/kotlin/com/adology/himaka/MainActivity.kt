package com.adology.himaka

import android.os.Bundle
import android.util.Log
import com.emeint.android.fawryplugin.Plugininterfacing.FawrySdk
import com.emeint.android.fawryplugin.Plugininterfacing.PayableItem
import com.emeint.android.fawryplugin.interfaces.FawrySdkCallback
import com.emeint.android.fawryplugin.managers.FawryPluginAppClass
import com.emeint.android.fawryplugin.views.cutomviews.FawryButton
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.*

class MainActivity : FlutterActivity(), FawrySdkCallback {
    lateinit var paymentResult: MethodChannel.Result

    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
       MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, Channel).setMethodCallHandler { methodCall: MethodCall?, result: MethodChannel.Result? ->
            val items: MutableList<PayableItem> = ArrayList()
           Log.i("el cost:", methodCall?.argument<String>("cost"))
           val item = Item("5Himaka", "description", "1", methodCall?.argument<String>("cost"))
//            item.setPrice("50")
//            item.setDescription("test2")
//            item.qty = "1"
//            item.sku = "1"
            items.add(item)
            FawryPluginAppClass.enableLogging = false
            val serverUrl = "https://atfawry.fawrystaging.com"
//           val merchantID = "1tSa6uxz2nR8NtecAqS5fQ=="
           val merchantID = "1tSa6uxz2nQvR6pbttqFMg=="
//            FawryPluginAppClass.skipCustomerInput = true
//            FawryPluginAppClass.username = "01146114834"
//            FawryPluginAppClass.email = "maged.soham@fawry.com"
            FawrySdk.init(FawrySdk.Styles.STYLE1)
            val merchantRefNumber: String = randomAlphaNumeric(16)
            try {
                FawrySdk.initialize(this, serverUrl, this, merchantID, merchantRefNumber, items, FawrySdk.Language.EN, 0, null, UUID(1, 2))
                FawryButton(this).callOnClick()
                paymentResult = result!!
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    companion object {
        private const val Channel = "intergration"
        private const val ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        fun randomAlphaNumeric(count: Int): String {
            var count = count
            val builder = StringBuilder()
            while (count-- != 0) {
                val character = (Math.random() * ALPHA_NUMERIC_STRING.length).toInt()
                builder.append(ALPHA_NUMERIC_STRING.get(character))
            }
            return builder.toString()
        }
    }

    override fun paymentOperationSuccess(s: String?, o: Any?) {
        Log.i("0", s + o.toString())
        paymentResult.success(s)
    }

    override fun paymentOperationFailure(s: String?, o: Any?) {
        Log.i("1", s + o.toString())
    }
}