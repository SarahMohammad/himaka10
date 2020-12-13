package com.adology.himaka

import com.emeint.android.fawryplugin.Plugininterfacing.PayableItem
import java.io.Serializable

class Item : PayableItem, Serializable {
    private var description: String? = ""
    private var price: String? = ""
    var originalPrice: String? = ""
    var sku: String? = ""
    var qty: String? = ""
    var height: String? = ""
    var length: String? = ""
    var weight: String? = ""
    var width: String? = ""
    var variantCode: String? =""
    var reservationCodes: Array<String> = emptyArray<String>()
    var earningRuleID: String? = ""
    fun setDescription(description: String?) {
        this.description = description
    }

    fun setPrice(price: String?) {
        this.price = price
    }

    constructor() {}
    constructor(productSKU: String?, description: String?, quantity: String?, price: String?) {
        sku = productSKU
        setDescription(description)
        qty = quantity
        setPrice(price)
    }

    override fun getFawryItemOriginalPrice(): String {
        return originalPrice!!
    }

    override fun getFawryItemDescription(): String {
        return description!!
    }

    override fun getFawryItemSKU(): String {
        return sku!!
    }

    override fun getFawryItemPrice(): String {
        return price!!
    }

    override fun getFawryItemQuantity(): String {
        return qty!!
    }

    override fun getFawryItemVariantCode(): String {
        return variantCode!!
    }

    override fun getFawryItemReservationCodes(): Array<out String>? {
        return reservationCodes
    }

    override fun getFawryItemHeight(): String {
        return height!!
    }

    override fun getFawryItemLength(): String {
        return length!!
    }

    override fun getFawryItemWeight(): String {
        return weight!!
    }

    override fun getFawryItemEarningRuleID(): String {
        return earningRuleID!!
    }

    override fun getFawryItemWidth(): String {
        return width!!
    }
}