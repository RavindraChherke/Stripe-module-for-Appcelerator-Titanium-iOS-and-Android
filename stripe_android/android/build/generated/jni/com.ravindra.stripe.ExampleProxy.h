/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2011-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

/** This is generated, do not edit by hand. **/

#include <jni.h>

#include "Proxy.h"

		namespace com {
		namespace ravindra {
		namespace stripe {
			namespace stripeandroid {


class ExampleProxy : public titanium::Proxy
{
public:
	explicit ExampleProxy(jobject javaObject);

	static void bindProxy(v8::Handle<v8::Object> exports);
	static v8::Handle<v8::FunctionTemplate> getProxyTemplate();
	static void dispose();

	static v8::Persistent<v8::FunctionTemplate> proxyTemplate;
	static jclass javaClass;

private:
	// Methods -----------------------------------------------------------
	static v8::Handle<v8::Value> printMessage(const v8::Arguments&);
	static v8::Handle<v8::Value> setMessage(const v8::Arguments&);
	static v8::Handle<v8::Value> getMessage(const v8::Arguments&);
	static v8::Handle<v8::Value> setDefaultPublishableKey(const v8::Arguments&);
	static v8::Handle<v8::Value> createCard(const v8::Arguments&);

	// Dynamic property accessors ----------------------------------------
	static void setter_defaultPublishableKey(v8::Local<v8::String> property, v8::Local<v8::Value> value, const v8::AccessorInfo& info);
	static v8::Handle<v8::Value> getter_message(v8::Local<v8::String> property, const v8::AccessorInfo& info);
	static void setter_message(v8::Local<v8::String> property, v8::Local<v8::Value> value, const v8::AccessorInfo& info);
	static void setter_createCard(v8::Local<v8::String> property, v8::Local<v8::Value> value, const v8::AccessorInfo& info);

};

			} // namespace stripeandroid
		} // stripe
		} // ravindra
		} // com
