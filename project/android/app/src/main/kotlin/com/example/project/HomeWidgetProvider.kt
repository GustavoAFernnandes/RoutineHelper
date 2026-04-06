package com.example.project

import com.example.project.R

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class HomeWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                // Aqui pegamos o dado enviado pelo Flutter
                val title = widgetData.getString("title_key", "Sem título")
                val msg = widgetData.getString("message_key", "Sem mensagem")
                
                // Injetamos o texto no XML
                setTextViewText(R.id.widget_title, title)
                setTextViewText(R.id.widget_message, msg)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}